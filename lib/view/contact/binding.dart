import 'package:get/get.dart';

import 'logic.dart';

class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactLogic());
  }
}
