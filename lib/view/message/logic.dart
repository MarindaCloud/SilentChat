import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/db/dao/record_message_dao.dart';
import 'package:silentchat/db/db_manager.dart';
import 'package:silentchat/entity/UserReceiver.dart';
import 'package:silentchat/entity/chat_info.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/message_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/util/date_time_util.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'package:drift/drift.dart' as drift;
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
    UserReceiver userReceiver = UserReceiver();
    List<int> receiverIdList = await userReceiver.getReceiverList();
    //接受者总长度
    int receiverLength = receiverIdList.length;
    Log.i("接受者id长度: ${receiverLength}");
    Map<int,Message> cacheReceiverMap = {};
    List<Message> messageList = [];
    for(int receiverId in receiverIdList){
      Message? message = await userReceiver.getNewMessage(uid: uid,receiverId: receiverId);
      print('最新的消息：${message?.toJson()}');
      if(message == null){
        continue;
      }
      cacheReceiverMap[receiverId] = message;
      messageList.add(message);
    }
    var messageViewMap = await sortMessageRank(userReceiver,messageList,cacheReceiverMap);
    //排序处理，时间最近的优先排序
    state.messageViewMap.value = messageViewMap;
    print('涉及到的视图map详情: ${messageViewMap}');
  }

  /*
   * @author Marinda
   * @date 2023/6/17 14:19
   * @description 排序消息排行
   */
  Future<Map<String, Map<int, Message>>> sortMessageRank(UserReceiver userReceiver,List<Message> messageList,Map<int,Message> cacheReceiverMap) async{
    Map<String,Map<int,Message>> messageViewMap = {};
    messageList.sort((a,b)=>b.time!.compareTo(a.time!));
    Log.i('消息排序后：${messageList.map((e) => e.toJson()).toList()}');
    Map<int,Message> sortReceiverMessageMap = {};
    for(var element in messageList){
      for(int receiverTarget in cacheReceiverMap.keys){
        var receiverMessage = cacheReceiverMap[receiverTarget];
        if(receiverMessage! == element){
          sortReceiverMessageMap[receiverTarget] = element;
          continue;
        }
        continue;
      }
    }
    sortReceiverMessageMap.forEach((key, value) {
      Log.i('排序后的结果Map信息：Key: ${key},Value: ${value.toJson()}');
    });
    for(var receiverIdElement in sortReceiverMessageMap.keys){
      Message message = sortReceiverMessageMap[receiverIdElement]!;
      User user = await userReceiver.getEntity(uid: receiverIdElement) as User;
      String userName = user.userName ?? "";
      Map<int,Message> element = {
        receiverIdElement: message
      };
      messageViewMap[userName] = element;
    }
    return messageViewMap;
  }

  /*
   * @author Marinda
   * @date 2023/6/14 17:49
   * @description 插入缓存记录信息
   */
  insertCacheRecord(int receiverId,Message message) async{
    //插入至drift数据库
    var recordInfo = RecordMessageCompanion(receiverId:drift.Value(receiverId),message: drift.Value(json.encode(message.toJson())));
    var recordDao =  RecordMessageDao(DBManager());
    RecordMessageData recordMessageData = await recordDao.insertRecordMessage(recordInfo);
    Log.i("插入结果: ${recordMessageData.id}");
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
      Map<int,Message> data = state.messageViewMap[target] ?? {};
      int key = data.keys.first;
      Message message = data[key]!;
      if(data == null){ continue;}
      String time = DateTimeUtil.formatToDayDateTime(message!.time!);
      String content = message.content ?? "";
      Widget child = InkWell(
        child: Container(
          padding: EdgeInsets.only(right: 40.rpx, top: 30.rpx,left: 40.rpx),
          margin: EdgeInsets.only(bottom: 80.rpx),
          child: Row(
            children: [
              //头像
              Container(
                margin: EdgeInsets.only(right: 40.rpx),
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
                                    fontSize: 14,
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
          int type = message.type ?? -1;
          print("目标id: ${key}");
          toChat(key,type);
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
   * @description 前往Chat页 携带参数 id & type
   */
  void toChat(int id,int type){
    Map<String,int> args = {
      "id": id,
      "type": type
    };
    Get.toNamed("/chat",arguments: args);
  }

  @override
  void onClose() {

  }
}
