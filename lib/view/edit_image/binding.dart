import 'package:get/get.dart';

import 'logic.dart';

class EditImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditImageLogic());
  }
}
