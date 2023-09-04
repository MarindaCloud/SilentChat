import 'package:get/get.dart';
import 'package:silentchat/view/message/logic.dart';

import 'logic.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterLogic());
    Get.lazyPut(() => MessageLogic());
  }
}
