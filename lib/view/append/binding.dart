import 'package:get/get.dart';

import 'logic.dart';

class AppendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppendLogic());
  }
}
