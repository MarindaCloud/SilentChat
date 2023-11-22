import 'package:get/get.dart';

import 'logic.dart';

class ReleaseSpaceDynamicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReleaseSpaceDynamicLogic());
  }
}
