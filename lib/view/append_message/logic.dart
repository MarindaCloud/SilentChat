import 'dart:convert';

import 'package:get/get.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/friends_verify.dart';
import 'package:silentchat/entity/packet.dart';
import 'package:silentchat/entity/packet_verify_friend.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/verify_api.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:silentchat/socket/socket_handle.dart';
import 'package:silentchat/util/log.dart';
import 'state.dart';

class AppendMessageLogic extends GetxController {
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;
  final SocketHandle socketHandle = Get.find<SocketHandle>();
  final AppendMessageState state = AppendMessageState();

  @override
  void onInit() {
    var args = Get.arguments;
    state.type.value = args["type"];
    state.element = args["element"];
    // TODO: implement onInit
    super.onInit();
  }


  /*
   * @author Marinda
   * @date 2023/7/6 14:34
   * @description 发送朋友验证消息
   */
  sendFriendsVerify() async{
    var target = state.element;
    if(target is User){
      int uid = userState.uid.value;
      String text = state.controller.text;
      DateTime dt = DateTime.now();
      int status = 0;
      int tid = target.id ?? -1;
      FriendsVerify friendsVerify = FriendsVerify(uid: uid,message: text,tid: tid,time: dt,status: status);
      int resultCode = await VerifyAPI.insertFriendsVerify(friendsVerify);

      if(resultCode == -1 ){
        BotToast.showText(text: "发送好友验证失败，请重试！");
        return;
      }
      sendFriendsVerifyPacket(uid, tid, text);
      BotToast.showText(text: "成功发送好友验证消息！");
      state.controller.text = "";
    }
  }

  /*
   * @author Marinda
   * @date 2023/8/16 11:21
   * @description 发送验证包
   */
  sendFriendsVerifyPacket(int uid,int receiverId,String message){
    Packet packet = Packet(type: 3,object: PacketVerifyFriend(code: 1,uid: uid,receiverId: receiverId,verifyMsg: message));
    Log.i("朋友验证包：${packet.object.toJson()}");
    socketHandle.write(json.encode(packet));
  }
}
