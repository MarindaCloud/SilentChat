import 'package:get/get.dart';

import 'logic.dart';

class GroupAnnouncementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupAnnouncementLogic());
  }
}
