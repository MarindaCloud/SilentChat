import 'package:get/get.dart';

import 'logic.dart';

class MySpaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MySpaceLogic());
  }
}
