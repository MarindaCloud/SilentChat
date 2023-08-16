import 'dart:convert';

import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/chat_info.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/entity/packet_group.dart';
import 'package:silentchat/entity/packet_verify_friend.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/group_api.dart';
import 'package:silentchat/network/api/message_api.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/contact/logic.dart';
import 'package:silentchat/view/message/logic.dart';
/**
 * @author Marinda
 * @date 2023/6/16 17:13
 * @description
 */
class SocketGroupsOnMessage{
  static final SystemLogic systemLogic = Get.find<SystemLogic>();
  static final SystemState systemState = Get.find<SystemLogic>().state;
  static final UserState userState = Get.find<UserLogic>().state;
  static final UserLogic userLogic = Get.find<UserLogic>();
  
  /*
   * @author Marinda
   * @date 2023/8/16 16:13
   * @description 创建群聊
   */
  static create(PacketGroup packetGroup) {
    List<int> receiverIdList = packetGroup.receiverIdList ?? [];
    //如果当前用户是接受者
    if(receiverIdList.contains(userState.uid.value)){
      MessageLogic messageLogic = Get.find<MessageLogic>();
      messageLogic.initRecordMessage();
      //校验是否打开过ContactLogic
      if(Get.isRegistered<ContactLogic>()){
        ContactLogic contactLogic = Get.find<ContactLogic>();
        contactLogic.initGroupsInfo();
        Log.i("重新获取群聊信息");
      }
      Log.i("收到创建群聊包，群聊id：${packetGroup.gid}");

    }
  }
}