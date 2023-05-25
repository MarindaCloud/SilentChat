import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/view/contact/view.dart';
import 'package:silentchat/view/message/view.dart';

import 'state.dart';

class IndexLogic extends GetxController {
  final IndexState state = IndexState();

  @override
  void onInit() {
    state.contentWidget = Get.arguments;
    // TODO: implement onInit
    super.onInit();
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
        state.contentWidget = Container();
        break;
    }
    update();
  }

}
