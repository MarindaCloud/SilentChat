import 'package:get/get.dart';

import 'logic.dart';

class DynamicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DynamicLogic());
  }
}
