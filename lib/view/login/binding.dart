import 'package:get/get.dart';
import 'package:silentchat/view/message/logic.dart';

import 'logic.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginLogic());
    Get.lazyPut(() => MessageLogic());
  }
}
