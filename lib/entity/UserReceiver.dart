import 'package:flutter/cupertino.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/entity/chat_info.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/entity/receiver.dart';
import 'package:silentchat/entity/silent_chat_entity.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/message_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:get/get.dart';
/**
 * @author Marinda
 * @date 2023/6/12 15:05
 * @description 用户接收者
 */
class UserReceiver implements Receiver{
  final systemLogic = Get.find<SystemLogic>();
  final systemState = Get.find<SystemLogic>().state;

  int _id;
  UserReceiver(this._id);


  @override
  Future<SilentChatEntity> getEntity({int? uid}) async{
    int targetId = uid ?? this._id;
    User user = await UserAPI.selectByUid(targetId);
    return user;
  }

  @override
  Future<List<Message>> getMessageList() async{
    List<Message> messageList = [];
    //获取用户聊天记录详情
    List<ChatInfo> chatInfoList = await MessageAPI.selectUserChatInfo();
    for(ChatInfo chatInfo in chatInfoList){
      int mid = chatInfo.mid ?? 0;
      Message message = await MessageAPI.selectMessageById(mid);
      messageList.add(message);
    }
    return messageList;
  }

  @override
  Future<Message?> getNewMessage({int? uid, int? receiverId}) async{
    if(uid == null || receiverId == null) return null;
    //获取用户聊天记录详情
    List<ChatInfo> chatInfoList = await MessageAPI.selectUserChatInfo();
    List<ChatInfo> filterList = chatInfoList.where((element) => element.sendId == uid && element.receiverId == receiverId || element.receiverId == uid && element.sendId == receiverId).toList();
    List<int> midList = filterList.map((e) => e.mid ?? 0).toList();
    List<Message> messageList = [];
    for(int mid in midList){
      Message message = await MessageAPI.selectMessageById(mid);
      messageList.add(message);
    }
    messageList.sort((a,b){
      DateTime bTime = b.time!;
      DateTime aTime = a.time!;
      return bTime.compareTo(aTime);
    });
    return messageList.first;
  }

  @override
  Future<List<int>> getReceiverList() async{
    List<ChatInfo> chatInfoList = await MessageAPI.selectUserChatInfo();
    int uid = systemState.user.id ?? 0;
    List<int> receiverIdList = chatInfoList.where((element) => element.sendId == uid && element.receiverId != uid).toList().map((e) => e.receiverId ?? 0).toList();
    List<int> sendIdList = chatInfoList.where((element) => element.receiverId == uid && element.sendId != uid).map((e) => e.sendId ?? 0).toList();
    List<int> list = [];
    list.addAll(receiverIdList);
    list.addAll(sendIdList);
    return list;
  }
}