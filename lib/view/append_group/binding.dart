import 'package:get/get.dart';

import 'logic.dart';

class AppendGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppendGroupLogic());
  }
}
