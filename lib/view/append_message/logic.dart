import 'package:get/get.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';

import 'state.dart';

class AppendMessageLogic extends GetxController {
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;
  final AppendMessageState state = AppendMessageState();

  @override
  void onInit() {
    var args = Get.arguments;
    state.type.value = args["type"];
    state.element = args["element"];
    // TODO: implement onInit
    super.onInit();
  }
}
