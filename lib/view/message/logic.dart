import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/entity/chat_info.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/message_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/util/date_time_util.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';

import 'state.dart';

/**
 * @author Marinda
 * @date 2023/6/9 17:30
 * @description 消息控制器
 */
class MessageLogic extends GetxController {
  final MessageState state = MessageState();
  final systemState = Get.find<SystemLogic>().state;
  final systemLogic = Get.find<SystemLogic>();


  @override
  void onInit() {
    Log.i("消息页初始化！");
    initRecordMessage();
  }

  /*
   * @author Marinda
   * @date 2023/6/12 11:34
   * @description 初始化最近聊天信息
   */
  void initRecordMessage() async{
    int uid = systemState.user.id ?? 0;
    //获取用户聊天记录详情
    List<ChatInfo> chatInfoList = await MessageAPI.selectUserChatInfo();
    //储存用户发送过的目标或者被动接受过的目标的id列表
    List<int> receiverIdList = [];
    Map<int,List<int>> cacheMessageMap = {};
    Map<String,Message> messageViewMap = {};
    for(ChatInfo chatInfo in chatInfoList){
      int mid = chatInfo.mid ?? 0;
      int sendId = chatInfo.sendId ?? 0;
      int receiverId = chatInfo.receiverId ?? 0;
      //该用户作为发送者
      if(sendId == uid && receiverId != uid){
        receiverIdList.add(receiverId);
        if(cacheMessageMap.containsKey(receiverId)){
          List<int> midList = cacheMessageMap[receiverId] ?? [];
          List<int> newList = [];
          newList.addAll(midList);
          newList.add(mid);
          cacheMessageMap[receiverId] = newList;
        }else{
          cacheMessageMap[receiverId] = [mid];
        }
      }
      //该用户作为接受者
      if(receiverId == uid && sendId != uid){
        receiverIdList.add(sendId);
        if(cacheMessageMap.containsKey(sendId)){
          List<int> midList = cacheMessageMap[sendId] ?? [];
          List<int> newList = [];
          newList.addAll(midList);
          newList.add(mid);
          cacheMessageMap[sendId] = newList;
        }else{
          cacheMessageMap[sendId] = [mid];
        }
      }
      // Message message = await MessageAPI.selectMessageById(mid);
    }

    for(int id in cacheMessageMap.keys){
      List<int> midList = cacheMessageMap[id] ?? [];
      Message message = await getNewMessage(midList);
      User user = await UserAPI.selectByUid(id);
      messageViewMap[user.userName?? ""] = message;
    }
    state.messageViewMap.value = messageViewMap;
    print('涉及到的相关接收者信息: ${receiverIdList.toSet()}');
    print('涉及到的相关记录详情: ${cacheMessageMap}');
    print('涉及到的视图map详情: ${messageViewMap}');
  }



  /*
   * @author Marinda
   * @date 2023/6/12 14:21
   * @description 
   */
  Future<Message> getNewMessage(List<int> midList) async{
    List<Message> messageList = [];
    for(int mid in midList){
      Message message = await MessageAPI.selectMessageById(mid);
      messageList.add(message);
    }
    messageList.sort((a,b)=>b.time!.compareTo(a.time!));
    Log.i('排序后的messageList: ${messageList.map((e) => e.toJson()).toList()}');
    return messageList.first;
  }

  /*
   * @author Marinda
   * @date 2023/5/25 15:24
   * @description 构建工具列表
   */
  List<Widget> buildToolsList(){
    List<Widget> list = [];
    //创建群聊 添加好友 扫一扫
    for(int i = 0;i<3;i++){
      Widget child = InkWell(
        child: Container(
          height: 100.rpx,
          margin: EdgeInsets.only(bottom: i == 2? 0 :  100.rpx),
          child: Row(
            children: [
              //图标
              Container(
                margin: EdgeInsets.only(right: 30.rpx),
                width: 100.rpx,
                height: 100.rpx,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset("assets/logo.jpg").image,
                    fit: BoxFit.fill
                  )
                ),
              ),
            //  文字
              Expanded(child: Text(
                getToolName(i),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
              ))
            ],
          ),
        ),
        onTap: (){
          print(getToolName(i));
        },
      );
      list.add(child);
    }
    return list;
  }

  /*
   * @author Marinda
   * @date 2023/5/25 15:51
   * @description 构建聊天记录
   */
   buildRecordList(){
    List<Widget> list = [];
    for(String target in state.messageViewMap.keys){
      Message? message = state.messageViewMap[target];
      if(message == null){ continue;}
      String time = DateTimeUtil.formatToDayDateTime(message!.time!);
      String content = message.content ?? "";
      Widget child = InkWell(
        child: Container(
          padding: EdgeInsets.only(right: 40.rpx, top: 10.rpx,left: 40.rpx),
          margin: EdgeInsets.only(bottom: 80.rpx),
          child: Row(
            children: [
              //头像
              Container(
                margin: EdgeInsets.only(right: 20.rpx),
                width: 200.rpx,
                height: 200.rpx,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10000),
                    image: DecorationImage(
                        image: Image.asset("assets/user/portait.png").image,
                        fit: BoxFit.fill
                    )
                ),
              ),
              //名称 & 最新消息
              Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        //名称
                        Container(
                          child: Row(
                            children: [
                              //  名称
                              Text(
                               target,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              //时间
                              Container(
                                child: Text("${time}",style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),),
                              )
                            ],
                          ),
                        ),
                        //最新消息
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${content}",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
        onTap: (){
          print("target: ${target}");
          toChat(1);
        },
      );
      list.add(child);
    }
    return list;
  }


  /*
   * @author Marinda
   * @date 2023/5/25 15:30
   * @description 获取工具名称
   */
  String getToolName(int index){
    String result = "";
    switch(index){
      case 0:
        result = "创建群聊";
        break;
      case 1:
        result = "加好友/群";
        break;
      case 2:
        result = "扫一扫";
        break;
    }
    return result;
  }

  /*
   * @author Marinda
   * @date 2023/5/26 10:55
   * @description 前往Chat页
   */
  void toChat(int i){
    Get.toNamed("/chat");
  }

  @override
  void onClose() {

  }
}
