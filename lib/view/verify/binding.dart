import 'package:get/get.dart';

import 'logic.dart';

class VerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyLogic());
  }
}
