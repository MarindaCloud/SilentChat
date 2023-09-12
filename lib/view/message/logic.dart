import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/db/dao/cache_record_message_dao.dart';
import 'package:silentchat/db/dao/record_message_dao.dart';
import 'package:silentchat/db/db_manager.dart';
import 'package:silentchat/entity/chat_message.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/group_receiver.dart';
import 'package:silentchat/entity/receiver.dart';
import 'package:silentchat/entity/silent_chat_entity.dart';
import 'package:silentchat/entity/user_receiver.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/chat_info.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/enum/message_type.dart';
import 'package:silentchat/network/api/group_api.dart';
import 'package:silentchat/network/api/message_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/util/date_time_util.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'package:drift/drift.dart' as drift;
import 'state.dart';
import 'package:device_info_plus/device_info_plus.dart';
/**
 * @author Marinda
 * @date 2023/6/9 17:30
 * @description 消息控制器
 */
class MessageLogic extends GetxController {
  final MessageState state = MessageState();
  final systemState = Get.find<SystemLogic>().state;
  final systemLogic = Get.find<SystemLogic>();
  final userLogic = Get.find<UserLogic>();
  final userState = Get.find<UserLogic>().state;


  @override
  void onInit() {
    Log.i("消息页初始化！");
    initRecordMessage();
  }


  @override
  void dispose() {
    state.messageViewMap.value = {};
    // TODO: implement dispose
    super.dispose();
  }
  

  /*
   * @author Marinda
   * @date 2023/6/12 11:34
   * @description 初始化最近聊天信息
   */
  void initRecordMessage() async{
    int uid = userState.user.value.id ?? 0;
    final db = DBManager();
    //未读已读消息缓存
    List<CacheViewMessageData> list = await CacheViewMessageDao(db).queryList();
    //获取用户聊天记录详情
    UserReceiver userReceiver = UserReceiver();
    GroupReceiver groupReceiver = GroupReceiver();
    //获取用户接受者id列表
    List<int> receiverIdList = await userReceiver.getReceiverList();
    //获取群组接收者id列表
    List<int> groupReceiverIdList = await groupReceiver.getReceiverList();
    Map<SilentChatEntity,Message> cacheReceiverMap = {};
    Map<SilentChatEntity,List<Message>> cacheMap = {};
    //接受者总长度
    int receiverLength = receiverIdList.length;
    Log.i("接受者id长度: ${receiverLength}");
    Log.i("接受者id列表：userReceiverIdList: ${receiverIdList},groupReceiverIdList: ${groupReceiverIdList}");
    for(var element in receiverIdList){

    //  获取当前用户所有的聊天列表
      List<Message> selectUserMessageList = await MessageAPI.selectUserMessageList(userState.user.value.id ?? 0, element);
      List<Message> msgList = [];
      if(list.isNotEmpty){
        var filterMsgList = filterMessageList(list.last.time, selectUserMessageList);
        msgList.addAll(filterMsgList);
      }

    //  遍历用户接受者数据
      Message? message = await userReceiver.getNewMessage(id: userState.user.value.id,receiverId: element);
      if(message == null){
        continue;
      }
      User user = await userLogic.selectByUid(element);
      Log.i("符合条件的列表共有：${msgList.map((e) => e.toJson()).toList()}");
      if(msgList.isNotEmpty){
        cacheMap[user] = msgList.toSet().toList();
      }
      cacheReceiverMap[user] = message;
    }
    for(var element in groupReceiverIdList){

      //  获取当前用户所有的聊天列表
      List<Message> selectUserMessageList = await MessageAPI.selectGroupMessageList(element);
      List<Message> msgList = [];
      if(list.isNotEmpty){
        var filterMsgList = filterMessageList(list.last.time, selectUserMessageList);
        msgList.addAll(filterMsgList);
      }

      //  遍历用户接受者数据
      Message? message = await groupReceiver.getNewMessage(id: userState.user.value.id,receiverId: element);
      if(message == null){
        continue;
      }
      Group group = await GroupAPI.selectById(element);
      if(msgList.isNotEmpty){
        cacheMap[group] = msgList.toSet().toList();
      }
      cacheReceiverMap[group] = message;
    }
    state.messageViewMap.value = cacheReceiverMap;
    userState.messageMap.value = cacheMap;
    //排序处理，时间最近的优先排序
    sortRecordMessage();
  }

  /*
   * @author Marinda
   * @date 2023/8/10 14:37
   * @description 排序消息记录
   */
  void sortRecordMessage(){
    var ele = state.messageViewMap.entries.toList()..sort((a,b){
      DateTime dt = a.value.time!;
      DateTime dt2 = b.value.time!;
      return dt2.compareTo(dt);
    });
    Map<SilentChatEntity, Message> sortedMap = {
      for (var entry in ele) entry.key: entry.value,
    };
    state.messageViewMap.value = sortedMap;
    print('涉及到的视图map详情: ${sortedMap}');
  }

  /*
   * @author Marinda
   * @date 2023/9/12 14:02
   * @description 过滤消息列表
   */
  List<Message> filterMessageList(DateTime dt,List<Message> list){
    List<Message> msgList = [];
    for(var element in list){
      var msgDateTime = element.time!;
      if(msgDateTime.isAfter(dt)){
        msgList.add(element);
      }
    }
    return msgList;
  }

  /*
   * @author Marinda
   * @date 2023/8/10 14:13
   * @description 插入消息至当页
   */
  insertMessage(dynamic element,int type,Message message,{ChatMessage? chatMessage}) async{
    //如果当前消息页不存在这个目标则添加
    if(!state.messageViewMap.containsKey(element)){
      if(element is User){
        //如果接受者id不是当前用户
        if(element.id != userState.uid.value){
          state.messageViewMap[element] = message;
        }else{
        //  如果接受者是自己，则获取发送者进行消息替换
          if(chatMessage != null){
            User sendUser = await userLogic.selectByUid(chatMessage.uid ?? -1);
            var targetKey = User();
            for(var ele in state.messageViewMap.keys){
              if(ele is User){
                if(ele.username == sendUser.username){
                  targetKey = ele;
                  break;
                }
              }
            }
            state.messageViewMap[targetKey] = message;
          }
        }
      }else{
        SilentChatEntity target = state.messageViewMap.keys.firstWhere((element){
          Group group = element as Group;
          return group.id == element.id;
        });
        if(target == null){
          state.messageViewMap[element] = message;
        }else{
          state.messageViewMap[target] = message;
        }
      }
    }else{
    //  如果存在则替换
      state.messageViewMap[element] = message;
      Log.i("存在该消息，替换最新消息");
    }
    sortRecordMessage();
  }



  /*
   * @author Marinda
   * @date 2023/7/24 18:43
   * @description 获取和目标的所有聊天记录列表
   */
  Future<List<Message>> getAllMessageByReceiver(List<int> receiverIdList,Receiver receiver) async{
    List<Message> messageList = [];
    for(int receiverId in receiverIdList){
      Message? message = await receiver.getNewMessage(id: userState.user.value.id ?? -1,receiverId: receiverId);
      print('最新的消息：${message?.toJson()}');
      if(message == null){
        continue;
      }
      messageList.add(message);
    }
    return messageList;
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
                  color: Colors.black,
                  fontSize: 15
                ),
              ))
            ],
          ),
        ),
        onTap: (){
          print(getToolName(i));
          switch(i){
            case 0:
              Get.toNamed(AppPage.appendGroup);
              break;
            case 1:
              Get.toNamed(AppPage.append);
              break;
            case 2:
              Get.toNamed(AppPage.qr);
              break;
          }
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
    for(SilentChatEntity target in state.messageViewMap.keys){
      Message? message = state.messageViewMap[target];
      int mid = message?.id ?? 0;
      int type = 0;
      if(target is User){
        type = 1;
      }else{
        type = 2;
      }
      if(message == null){ continue;}
      String time = DateTimeUtil.formatToDayDateTime(message.time ?? DateTime.now());
      String content = message.content ?? "";
      String resultContent = "";
      if(message.type != 1){
        switch(message.type){
          case 2:
            resultContent = "[图片消息]";
            break;
          case 3:
            resultContent = "[语音消息]";
            break;
          case 4:
            resultContent = "[文件消息]";
            break;
        }
      }
      var portrait = type == 1 ? (target as User).portrait ?? "" : (target as Group).portrait ?? "";
      Widget child = GestureDetector(
        onHorizontalDragUpdate: (val){
          var delta = val.delta;
          if(delta.dx < 0){
            state.onHorizontalDragMessageList.add(message);
          }else{
            state.onHorizontalDragMessageList.remove(message);
          }
        },
        child: InkWell(
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
                          image: userLogic.buildPortraitWidget(1,portrait).image,
                          fit: BoxFit.fill
                      )
                  ),
                ),
                //名称 & 最新消息
                Expanded(
                    child: state.onHorizontalDragMessageList.contains(message) ?
                    Container(
                      child: Row(
                        children: [
                        //  左边详情
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //名称
                                Container(
                                  child: Text(
                                    type == 1 ? (target as User).username ?? "" : (target as Group).name ?? "",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ),
                                //left
                                Container(
                                  child: Text(
                                    message.type != 1 ? resultContent : content,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          //操作栏
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //置顶
                                InkWell(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10.rpx),
                                    width: 250.rpx,
                                    height: 150.rpx,
                                    decoration: BoxDecoration(
                                        color: Colors.grey  ,
                                        borderRadius: BorderRadius.circular(5.rpx)
                                    ),
                                    child: Center(
                                        child: Text("置顶",style: TextStyle(color: Colors.white,fontSize: 16),)
                                    ),
                                  ),
                                  onTap: (){
                                    //置顶功能待定，没想好怎么实现
                                    print("置顶");
                                  },
                                ),
                                //移除
                                InkWell(
                                  child: Container(
                                    width: 250.rpx,
                                    height: 150.rpx,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5.rpx)
                                    ),
                                    child: Center(
                                        child: Text("移除",style: TextStyle(color: Colors.white,fontSize: 16),)
                                    ),
                                  ),
                                  onTap: (){
                                   state.messageViewMap.remove(target);
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ) :Container(
                      child: Column(
                        children: [
                          //名称
                          Container(
                            child: Row(
                              children: [
                                //  名称
                                Text(
                                 type == 1 ? (target as User).username ?? "" : (target as Group).name ?? "",
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //left
                                Container(
                                  child: Text(
                                    message.type != 1 ? resultContent : content,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ),
                                //未读消息
                                Visibility(
                                  visible: userState.messageMap[target]?.isNotEmpty ?? false,
                                  child: Container(
                                    width: 80.rpx,
                                    height: 80.rpx ,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10000)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${userState.messageMap[target]?.length}",
                                        style: TextStyle(color: Colors.white,fontSize: 16),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
          onTap: () {
            var key = type == 1 ? (target as User).id : (target as Group).id;
            print("当前选择的id: ${key}");
            toChat(target,type,mid);
          },
        ),
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
  void toChat(dynamic element,int type,int mid) async{
    int id = element.id;
    final db = DBManager();
    var data = CacheViewMessageCompanion(
      time: drift.Value(DateTime.now()),
      mid: drift.Value(mid),
      ownerId: drift.Value(id),
      element: drift.Value(json.encode(element))
    );
    CacheViewMessageData cacheViewMessageData = await CacheViewMessageDao(db).insertReturning(data);
    Log.i("插入结果: ${cacheViewMessageData}");
    Map<String,int> args = {
      "id": id,
      "type": type
    };
    //result = true 则视为Chat页发送过消息所以刷新所有数据
    var result = await Get.toNamed("/chat",arguments: args);
    if(result){
      Log.i("重置");
      initRecordMessage();
    }
  }

  @override
  void onClose() {

  }
}
