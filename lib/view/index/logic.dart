import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/logic/cache_image_handle.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/packet.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/socket/socket_handle.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/contact/view.dart';
import 'package:silentchat/view/dynamic/view.dart';
import 'package:silentchat/view/message/logic.dart';
import 'package:silentchat/view/message/view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'state.dart';

class IndexLogic extends GetxController {
  final IndexState state = IndexState();
  final socketHandle = Get.find<SocketHandle>();
  final userLogic = Get.find<UserLogic>();
  final userState = Get.find<UserLogic>().state;
  final systemLogic = Get.find<SystemLogic>();
  final systemState = Get.find<SystemLogic>().state;

  @override
  void onInit() async{
    BotToast.showLoading();
    await initInfo();
    ever(userState.user, (target){
      Log.i("修改前User头像: ${userState.user.value.portrait}，修改后User：${target.portrait}");
      userState.user.value = target;
    });
    initSocket();
    changeNavView(0);
    BotToast.closeAllLoading();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  /*
   * @author Marinda
   * @date 2023/9/9 15:28
   * @description 初始化相关信息
   */
  initInfo() async{
    await userLogic.initFriendsList();
    await userLogic.initGroupsList();
  }

  /*
   * @author Marinda
   * @date 2023/5/29 10:54
   * @description 连接Socket
   */
  void initSocket() {
    socketHandle.open();
    state.webSocketChannel = socketHandle.webSocketChannel;
    User user = userState.user.value;
    Packet packet = Packet(type: 1, object: user);
    String packetJSON = json.encode(packet);
    Log.i("初始化Socket连接包：${packetJSON}");
    Future.delayed(Duration(milliseconds: 300),(){
      socketHandle.write(packetJSON);
      Log.i("初始化包发送完毕");
    });

  }

  /*
   * @author Marinda
   * @date 2023/9/9 11:09
   * @description 退出登录
   */
  exitLogin(){
    systemState.showHistory.value = false;
    CacheImageHandle.removeCache();
    Get.offAllNamed(AppPage.login);
    Log.i("退出登录！");
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
