import 'package:get/get.dart';

import 'logic.dart';

class SpaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SpaceLogic());
  }
}
