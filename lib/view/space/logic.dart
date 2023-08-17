import 'package:get/get.dart';
import 'package:silentchat/controller/user/logic.dart';

import 'state.dart';

class SpaceLogic extends GetxController {
  final SpaceState state = SpaceState();
  final userLogic = Get.find<UserLogic>();
  final userState = Get.find<UserLogic>().state;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
