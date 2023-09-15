import 'dart:convert';
import 'package:silentchat/controller/system/logic.dart';
import 'package:silentchat/controller/system/state.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/packet_verify_friend.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/contact/logic.dart';
/**
 * @author Marinda
 * @date 2023/6/16 17:13
 * @description
 */
class SocketFriendsOnMessage{
  static final SystemLogic systemLogic = Get.find<SystemLogic>();
  static final SystemState systemState = Get.find<SystemLogic>().state;
  static final UserState userState = Get.find<UserLogic>().state;
  static final UserLogic userLogic = Get.find<UserLogic>();

  /*
   * @author Marinda
   * @date 2023/6/16 17:28
   * @description 接收到消息
   */
  static append(PacketVerifyFriend packetVerifyFriend) async{
    //如果当前用户是接受者
    if(packetVerifyFriend.receiverId == userState.uid.value){
      BotToast.showText(text: "你收到了一个好友验证消息！");
    }
  }

  /*
   * @author Marinda
   * @date 2023/6/16 17:28
   * @description 用户通过好友请求
   */
  static accept(PacketVerifyFriend packetVerifyFriend) async{
    //如果当前用户是接受者
    if(packetVerifyFriend.receiverId == userState.uid.value){
      User user = await userLogic.selectByUid(packetVerifyFriend.uid!);
      userState.friendUserList.add(user);
      // ContactLogic contactLogic = Get.find<ContactLogic>();
      // contactLogic.insertContact(user);
      // userState.friendsViewInfoList;
      BotToast.showText(text: "已添加用户: ${user.username}为好友！");
      Log.i("已添加用户: ${user.username}为好友！");
    }
  }

  /*
   * @author Marinda
   * @date 2023/6/16 17:28
   * @description 用户拒绝好友请求
   */
  static refuse(PacketVerifyFriend packetVerifyFriend) async{
    //如果当前用户是接受者
    if(packetVerifyFriend.receiverId == userState.uid.value){
      Log.i("用户: ${packetVerifyFriend.uid}拒绝了好友请求！");
    }
  }
}