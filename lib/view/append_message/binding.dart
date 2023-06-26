import 'package:get/get.dart';

import 'logic.dart';

class AppendMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppendMessageLogic());
  }
}
