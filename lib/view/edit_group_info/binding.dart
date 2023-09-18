import 'package:get/get.dart';

import 'logic.dart';

class EditGroupInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditGroupInfoLogic());
  }
}
