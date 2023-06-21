import 'package:get/get.dart';

import 'logic.dart';

class UserInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserInfoLogic());
  }
}
