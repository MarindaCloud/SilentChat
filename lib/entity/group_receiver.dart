import 'package:flutter/cupertino.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/chat_info.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/entity/receiver.dart';
import 'package:silentchat/entity/silent_chat_entity.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/group_api.dart';
import 'package:silentchat/network/api/message_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/log.dart';

/**
 * @author Marinda
 * @date 2023/7/24 18:23
 * @description 群组接受者
 */
class GroupReceiver implements Receiver{
  final userLogic = Get.find<UserLogic>();
  final userState = Get.find<UserLogic>().state;

  GroupReceiver();


  @override
  Future<SilentChatEntity> getEntity({int? id}) async{
    Group group = await GroupAPI.selectById(id!);
    return group;
  }

  @override
  Future<List<Message>> getMessageList() async{
    List<Message> messageList = [];
    //获取用户聊天记录详情
    List<ChatInfo> chatInfoList = await MessageAPI.selectUserChatInfo();
    //这里是做筛选聊天记录为群聊消息
    List<ChatInfo> userGroupChatInfoList = chatInfoList.where((element) => element.type == 2).toList();
    Log.i("该用户群聊消息数据为：${userGroupChatInfoList.map((e) => e.toJson()).toList()}");
    for(ChatInfo chatInfo in userGroupChatInfoList){
      int mid = chatInfo.mid ?? 0;
      Message message = await MessageAPI.selectMessageById(mid);
      messageList.add(message);
    }
    return messageList;
  }

  @override
  Future<Message?> getNewMessage({int? id, int? receiverId}) async{
    if(id == null || receiverId == null) return null;
    Log.i("获取${receiverId}群组最新聊天记录");
    Message message = await MessageAPI.selectNewMessage(id, receiverId,2);
    Log.i("${receiverId}群组最新聊天记录为：${message.toJson()}");
    return message;
  }



  @override
  Future<List<int>> getReceiverList() async{
    List<ChatInfo> chatInfoList = await MessageAPI.selectGroupChatInfos();
    int uid = userState.uid.value;
    List<int> receiverIdList = chatInfoList.where((element) => element.receiverId != null && element.type == 2).toList().map((e) => e.receiverId ?? 0).toList();
    List<int> list = [];
    list.addAll(receiverIdList);
    return list.toSet().toList();
  }

  /*
   * @author Marinda
   * @date 2023/6/12 17:19
   * @description 获取和该接受者的所有聊天记录信息
   */
  Future<List<Message>> getTargetMessageList(int receiverId) async{
    int uid = userState.uid.value;
    List<ChatInfo> chatInfo = await MessageAPI.selectUserChatInfo();
    List<Message> messageList = [];
    List<int> midList = chatInfo.where((e) => e.sendId == uid && e.receiverId == receiverId || e.sendId == receiverId && e.receiverId == uid).toList().map((e) => e.mid?? 0).toList();
    print('消息id列表: ${midList}');
    for(int mid in midList){
     Message message = await MessageAPI.selectMessageById(mid);
     messageList.add(message);
    }
    return messageList;
  }


}