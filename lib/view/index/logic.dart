import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/packet.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/socket/socket_handle.dart';
import 'package:silentchat/socket/socket_handle.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/contact/view.dart';
import 'package:silentchat/view/dynamic/view.dart';
import 'package:silentchat/view/message/view.dart';

import 'state.dart';

class IndexLogic extends GetxController {
  final IndexState state = IndexState();

  @override
  void onInit() {
    state.contentWidget = Get.arguments;
    initSocket();
    // TODO: implement onInit
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/5/29 10:54
   * @description 连接Socket
   */
  void initSocket() async{
    var socketHandle = Get.find<SocketHandle>();
    state.webSocketChannel = socketHandle.webSocketChannel;
    User user = User(uid: 2,userName: "小明");
    Packet packet = Packet(type: 1, object: user);
    String packetJSON = json.encode(packet.toJson());
    Log.i("初始化Socket连接包：${packetJSON}");
    socketHandle.write(packetJSON);
  }

  /*
   * @author Marinda
   * @date 2023/5/25 16:21
   * @description 切换视图
   */
  changeNavView(int index){
    print("index: ${state.index.value}");
    state.index.value = index;
    switch(state.index.value){
      //消息
      case 0:
        state.contentWidget = MessagePage();
        break;
      //  联系人
      case 1:
        state.contentWidget = ContactPage();
        break;
      //  动态
      case 2:
        state.contentWidget = DynamicPage();
        break;
    }
    update();
  }

}
