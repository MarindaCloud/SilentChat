import 'package:get/get.dart';

import 'logic.dart';

class EditUserInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditUserInfoLogic());
  }
}
