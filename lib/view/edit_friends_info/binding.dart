import 'package:get/get.dart';

import 'logic.dart';

class EditFriendsInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditFriendsInfoLogic());
  }
}
