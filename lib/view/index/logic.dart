import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class IndexLogic extends GetxController {
  final IndexState state = IndexState();

  @override
  void onInit() {
    state.contentWidget = Get.arguments;
    // TODO: implement onInit
    super.onInit();
  }

}
