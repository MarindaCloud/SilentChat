import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';

import 'state.dart';

class AppendLogic extends GetxController {
  final AppendState state = AppendState();
  final SystemLogic logic = Get.find<SystemLogic>();
  final SystemState systemState = Get.find<SystemLogic>().state;

  @override
  void onInit() {
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/6/19 17:51
   * @description
   */
  List<Widget> buildWidget(){
    List<Widget> list = [];

    return list;
  }


}
