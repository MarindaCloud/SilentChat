import 'dart:convert';

import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/entity/chat_message.dart';
import 'package:silentchat/entity/packet.dart';
import 'package:get/get.dart';
import 'package:silentchat/enum/receiver_type.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/chat/logic.dart';
/**
 * @author Marinda
 * @date 2023/6/16 17:13
 * @description
 */
class SocketOnMessage{
  static final SystemLogic systemLogic = Get.find<SystemLogic>();
  static final SystemState systemState = Get.find<SystemLogic>().state;

  /*
   * @author Marinda
   * @date 2023/6/16 17:28
   * @description 接收到消息
   */
  static chatMessage(Packet packet) async{
    String message = json.encode(packet.object);
    dynamic result = json.decode(message);
    ChatMessage chatMessage = ChatMessage.fromJson(result);
    int type = chatMessage.receiverType?.type ?? -1;
    switch(type){
      //用户
      case 1:
        //如果在当前聊天页
        if(Get.isRegistered<ChatLogic>()){
          var chatLogic = Get.find<ChatLogic>();
          await chatLogic.syncInsertMessage(chatMessage);
          Log.i("插入异步消息！");
        }
        break;
      //  群聊
      case 2:
        break;
    }
  }
}