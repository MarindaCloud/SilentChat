import 'dart:convert';
import 'package:silentchat/controller/system/logic.dart';
import 'package:silentchat/controller/system/state.dart';
import 'package:silentchat/entity/chat_message.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/entity/packet.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/packet_group.dart';
import 'package:silentchat/entity/packet_verify_friend.dart';
import 'package:silentchat/enum/receiver_type.dart';
import 'package:silentchat/enum/websocket_code.dart';
import 'package:silentchat/enum/websocket_friends_code.dart';
import 'package:silentchat/enum/websocket_groups_code.dart';
import 'package:silentchat/network/api/group_api.dart';
import 'package:silentchat/network/api/message_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/chat/logic.dart';
import 'package:silentchat/view/message/logic.dart';
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
    //如果在当前聊天页
    if(Get.isRegistered<ChatLogic>()){
      var chatLogic = Get.find<ChatLogic>();
      await chatLogic.syncInsertMessage(chatMessage);
      chatLogic.state.sendFlag = true;
      Log.i("插入通讯消息！");
    }else{
      var message = Get.find<MessageLogic>();
      var targetMessage = await MessageAPI.selectMessageById(chatMessage.mid ?? -1);
      Log.i("message: ${targetMessage.toJson()}");
      dynamic element;
      if(type == 1){
        var user = await UserAPI.selectByUid(chatMessage.receiverId ?? -1);
        element = user;
      }else{
        var group = await GroupAPI.selectById(chatMessage.receiverId ?? -1);
        element = group;
      }
      Log.i("消息目标: ${element.toJson()}");
      message.insertMessage(element, type, targetMessage,chatMessage: chatMessage);
      // message.insertMessage(group, 2, createGroupMsg);
    }
  }

  /*
   * @author Marinda
   * @date 2023/8/16 13:54
   * @description 朋友包处理
   */
  static friends(Packet packet) async{
    String message = json.encode(packet.object);
    dynamic result = json.decode(message);
    PacketVerifyFriend packetVerifyFriend = PacketVerifyFriend.fromJson(result);
    int code = packetVerifyFriend.code!;
    WebSocketFriendsCode friendsCode = WebSocketFriendsCode.getWebSocketCodeEnum(code)!;
    friendsCode.cbFn?.call(packetVerifyFriend);
  }

  /*
   * @author Marinda
   * @date 2023/8/16 13:54
   * @description 朋友包处理
   */
  static groups(Packet packet) async{
    String message = json.encode(packet.object);
    dynamic result = json.decode(message);
    PacketGroup packetGroup = PacketGroup.fromJson(result);
    int code = packetGroup.code!;
    WebSocketGroupsCode groupsCode = WebSocketGroupsCode.getWebSocketCodeEnum(code)!;
    groupsCode.cbFn?.call(packetGroup);
  }
}