import 'package:get/get.dart';

import 'logic.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordLogic());
  }
}
