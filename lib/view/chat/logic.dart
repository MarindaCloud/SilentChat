import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/UserReceiver.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/chat_message.dart';
import 'package:silentchat/entity/chat_record_data.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/entity/packet.dart';
import 'package:silentchat/entity/receiver.dart';
import 'package:silentchat/enum/message_type.dart';
import 'package:silentchat/network/api/message_api.dart';
import 'package:silentchat/socket/socket_handle.dart';
import 'package:silentchat/util/date_time_util.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silentchat/util/log.dart';
import 'state.dart';

class ChatLogic extends GetxController with GetSingleTickerProviderStateMixin{
  final ChatState state = ChatState();
  @override
  void onInit() {
    if(Get.arguments == null ) return;
    Map<String,int> args = Get.arguments;
    state.args = args;
    print('参数：${state.args}');
    initChatRecordDataList();
    state.socketHandle = Get.find<SocketHandle>();
    final ImagePicker picker = ImagePicker();
    state.picker = picker;
    state.animatedController = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    state.fadeValue = Tween<double>(begin: 0,end: 1).animate(state.animatedController!);
  }


  /*
   * @author Marinda
   * @date 2023/6/5 14:09
   * @description 初始化聊天记录信息列表
   */
  initChatRecordDataList() async{
    List<ChatRecordData> list = [];
    int id = state.args["id"] ?? -1;
    int type = state.args["type"] ?? -1;
    List<Message> messageList = [];
    if(type == 1){
      UserReceiver userReceiver = UserReceiver();
      messageList = await userReceiver.getTargetMessageList(id);
    }
    for(Message message in messageList){
      DateTime dt = message.time!;
      int type = message.type!;
      String portait = "assets/user/portait.png";
      String content = message.content ?? "";
      MessageType messageType = MessageType.getMessageType(type)!;
      ChatRecordData chatRecordData = ChatRecordData(targetId: message.id,messageType: messageType,message: content,portrait: portait,time: dt);
      list.add(chatRecordData);
    }
    state.chatRecordList.value = list;
    sortRecordInfo();
  }

  /*
   * @author Marinda
   * @date 2023/6/5 15:00
   * @description 排序记录信息
   * 因为每个消息他们发送的时间段都不一致
   * 而正常情况下也不会每一个时间段显示当条聊天记录
   * 所以我们需要对它进行记录排序，指定一个时间区间范围，整合成一个Map用来储存记录信息
   * 以下时间区间段为：每10分钟为一个区间，并且Map的key为最早的格式
   */
  sortRecordInfo(){
    Map<String,List<ChatRecordData>> recordMap = {};
    Map<DateTime,List<DateTime>> timeMap = {};
    List<DateTime> dateTimeList = [];
    //获取所有时间
    for(int i = 0 ;i<state.chatRecordList.length;i++){
      ChatRecordData element = state.chatRecordList[i];
      DateTime targetTime = element.time!;
      dateTimeList.add(targetTime);
    }
    List<DateTime> cloneDateTime = [];
    cloneDateTime.addAll(dateTimeList);
    //遍历克隆的所有时间
    for(DateTime startTime in cloneDateTime){
      List<DateTime> timeList = DateTimeUtil.getDateTimeInterval(startTime, dateTimeList, Duration(minutes: 10));
      //如果不存在这个key
      if(!timeMap.containsKey(startTime)){
      //  检查一下日期缓存中是否有存过这条日期
        print('valid: ${validTimeExists(startTime, timeMap)}');
        if(validTimeExists(startTime, timeMap)){
          break;
        }
        timeMap[startTime] = timeList;
      }
      continue;
    }
    Log.i("时间Map缓存数据：${timeMap}");
  //  遍历所有聊天列表数据
    for(ChatRecordData recordData in state.chatRecordList){
      DateTime targetTime = recordData.time!;
      //校验日期缓存的map中是否存在这个时间
      if(timeMap.containsKey(targetTime)){
        String chatRecordWeekDataString = DateTimeUtil.formatWeekDateTime(targetTime);
        //符合该条聊天记录区间的所有聊天信息
        List<ChatRecordData> subChatRecordList = state.chatRecordList.where((element){
          List<DateTime> timeList = timeMap[targetTime] ?? [];
          return timeList.contains(element.time);
        }).toList();
        recordMap[chatRecordWeekDataString] = subChatRecordList;
      }
    }
    state.recordMap.value = recordMap;
    Log.i("聊天记录Map数据: ${recordMap}");
  }

  /*
   * @author Marinda
   * @date 2023/6/5 17:12
   * @description 验证TimeExists
   */
  bool validTimeExists(DateTime targetDateTime,Map<DateTime,List<DateTime>> map){
    bool flag = false;
    for(DateTime key in map.keys){
      List<DateTime> list = map[key] ?? [];
      if(list.contains(targetDateTime)){
        flag = true;
        break;
      }
      print('是否存在过这个日期: ${list.contains(targetDateTime)}');
    }
    return flag;
  }
  /*
   * @author Marinda
   * @date 2023/5/29 18:41
   * @description 打开图像
   */
  void openImagePicker() async{
    final XFile? image = await state.picker!.pickImage(source: ImageSource.gallery);
  }

  /*
   * @author Marinda
   * @date 2023/6/3 11:35
   * @description 打开视频 模拟器没相机不好测试
   */
  void openVideoPicker() async{
    final XFile? video = await state.picker!.pickVideo(source: ImageSource.camera);
  }


  /*
   * @author Marinda
   * @date 2023/6/9 16:13
   * @description 插入消息
   */
  insertMessage(MessageType type,{String? expand_address}) async{
    String message = state.messageController.text;
    DateTime dateTime = DateTime.now();
    Message entity = Message(content: message,type: type.type,time: dateTime);
    if(expand_address != ""){entity.expandAddress = expand_address;}
    APIResult apiResult = await MessageAPI.insertMessage(entity);
    Log.i("插入结果：${apiResult.toJson()}");
    ChatRecordData recordData = new ChatRecordData();
    recordData.message = message;
    print('消息：${message}');
    recordData.targetId = 1;
    recordData.time = dateTime;
    recordData.messageType = type;
    recordData.portrait = "assets/user/portait.png";
    state.chatRecordList.add(recordData);
    sortRecordInfo();
  }



  /*
   * @author Marinda
   * @date 2023/6/3 14:07
   * @description 发送消息
   */
  void sendMessage() async{
    MessageType type = MessageType.TEXT;
    String message = state.messageController.text;
    if(message.isEmpty){ return;}
    await insertMessage(type);
    ChatMessage chatMessage = ChatMessage(uid: 1,chatMessage: message);
    Packet packet = Packet(type: 2,object: chatMessage);
    String packetJSON = json.encode(packet);
    state.socketHandle?.write(packetJSON);
    state.messageController.text = "";
  }

  /*
   * @author Marinda
   * @date 2023/6/3 11:30
   * @description 录音处理
   */
  void recording(){
    state.animatedController!.reset();
    state.animatedController!.forward();
    state.chooseRecording.value = !state.chooseRecording.value;
  }


  /*
   * @author Marinda
   * @date 2023/5/26 11:10
   * @description 构建聊天信息
   */
  List<Widget> buildChatMessage(){

    List<Widget> list = [];
    print('记录Map总长度: ${state.recordMap.length}');
    //遍历记录列表
    for(String key in state.recordMap.keys){
      List<ChatRecordData> element = state.recordMap[key] ?? [];
      Widget child = Container(
        child: Column(
          children: [
            //  时间
            Container(
              height: 200.rpx,
              child: Center(
                // child: Text("星期二 晚上 5:53"),
                child: Text("${key}"),
              ),
            ),
            //信息
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.rpx),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: buildChatRecordInfo(element),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
      list.add(child);
    }
    // for(int i = 0;i<.length;i++){
    //   var element = state.chatRecordList[i];
    //   String formatDateTime = DateTimeUtil.formatWeekDateTime(element.time!);
    //   Widget child = Container(
    //     child: Column(
    //       children: [
    //       //  时间
    //         Container(
    //           height: 200.rpx,
    //           child: Center(
    //             // child: Text("星期二 晚上 5:53"),
    //             child: Text("${formatDateTime}"),
    //           ),
    //         ),
    //         //信息
    //         Container(
    //           padding: EdgeInsets.symmetric(horizontal: 30.rpx),
    //           child: Column(
    //             children: [
    //               Container(
    //                 child: Column(
    //                   children: [...buildChatInfo(3, 2)],
    //                 ),
    //               ),
    //               // Visibility(
    //               //   visible: i > 5,
    //               //     child: Column(
    //               //       children: [...buildChatInfo(3, 2)],
    //               //     ),
    //               // ),
    //               Visibility(
    //                 visible: i < 5,
    //                 child: Column(
    //                   children: [...buildChatInfo(5, 1)],
    //                 ),
    //               )
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   );
    //   list.add(child);
    // }
    return list;
  }

  /*
   * @author Marinda
   * @date 2023/5/29 10:36
   * @description 构建聊天信息
   */

  // List<Widget> buildChatInfo(int num,int type){
  //   List<Widget> list = [];
  //   for(int i = 0;i<num;i++){
  //     Widget widget = Container(
  //       margin: EdgeInsets.only(bottom: 100.rpx),
  //       child: Row(
  //         mainAxisAlignment: type == 2 ? MainAxisAlignment.start : MainAxisAlignment.end,
  //         children: [
  //           ...buildChatItem(type)
  //         ],
  //       ),
  //     );
  //     list.add(widget);
  //   }
  //   return list;
  // }

  /*
   * @author Marinda
   * @date 2023/5/29 10:36
   * @description 构建聊天信息
   */

  List<Widget> buildChatRecordInfo(List<ChatRecordData> chatRecordDataList) {
    List<Widget> list = [];
    for (ChatRecordData chatRecordData in chatRecordDataList) {
      int receiverId = chatRecordData.targetId!;
      Widget widget = Container(
        margin: EdgeInsets.only(bottom: 100.rpx),
        child: Row(
          //receiverId = 1 自己 2其他
          mainAxisAlignment: receiverId == 1
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            ...buildChatRecordItem(chatRecordData)
          ],
        ),
      );
      list.add(widget);
    }
    return list;
    // for(int i = 0;i<num;i++){
    //   Widget widget = Container(
    //     margin: EdgeInsets.only(bottom: 100.rpx),
    //     child: Row(
    //       mainAxisAlignment: type == 2 ? MainAxisAlignment.start : MainAxisAlignment.end,
    //       children: [
    //         ...buildChatItem(type)
    //       ],
    //     ),
    //   );
    //   list.add(widget);
    // }

  }

  /*
   * @author Marinda
   * @date 2023/5/29 10:30
   * @description 构建聊天项目 type = 1 自己 type = 2其他
   */
  List<Widget> buildChatRecordItem(ChatRecordData chatRecordData){
    List<Widget> list = [];
    int receiverId = chatRecordData.targetId!;
    Widget expaned = SizedBox(width: 50.rpx);
    Widget message = Container(
      padding: EdgeInsets.all(40.rpx),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: receiverId == 1 ? Colors.blue : Colors.white
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: 800.rpx,
            minWidth: 200.rpx
        ),
        child: Text(
            "${chatRecordData.message}",
            style: TextStyle(color: receiverId == 1 ? Colors.white : Colors.black,fontSize: 14)
        ),
      ),
    );
    Widget portait = Container(
      margin: EdgeInsets.only(right: 20.rpx),
      width: 150.rpx,
      height: 150.rpx,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10000),
          image: DecorationImage(
              image: Image
                  .asset("assets/user/portait.png")
                  .image,
              fit: BoxFit.fill
          )
      ),
    );
    //自己
    if(receiverId == 1){
      list.add(message);
      list.add(expaned);
      list.add(portait);
    }else{
      list.add(portait);
      list.add(expaned);
      list.add(message);
    }
    return list;
  }

  /*
   * @author Marinda
   * @date 2023/5/29 10:30
   * @description 构建聊天项目 type = 1 自己 type = 2其他
   */
  // List<Widget> buildChatItem(ChatRecordData chatRecordData){
  //   List<Widget> list = [];
  //
  //   Widget expaned = SizedBox(width: 50.rpx);
  //   Widget message = Container(
  //     padding: EdgeInsets.all(40.rpx),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         color: type == 1 ? Colors.blue : Colors.white
  //     ),
  //     child: ConstrainedBox(
  //       constraints: BoxConstraints(
  //           maxWidth: 500.rpx,
  //           minWidth: 100.rpx
  //       ),
  //       child: Text(
  //           "这是一条新消息",
  //           style: TextStyle(color: type == 1 ? Colors.white : Colors.black,fontSize: 14)
  //       ),
  //     ),
  //   );
  //   Widget portait = Container(
  //     margin: EdgeInsets.only(right: 20.rpx),
  //     width: 150.rpx,
  //     height: 150.rpx,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10000),
  //         image: DecorationImage(
  //             image: Image
  //                 .asset("assets/user/portait.png")
  //                 .image,
  //             fit: BoxFit.fill
  //         )
  //     ),
  //   );
  //   //自己
  //   if(type == 1){
  //     list.add(message);
  //     list.add(expaned);
  //     list.add(portait);
  //   }else{
  //     list.add(portait);
  //     list.add(expaned);
  //     list.add(message);
  //   }
  //   return list;
  // }

}
