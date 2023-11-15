import 'package:get/get.dart';

import 'logic.dart';

class AppendAnnouncementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppendAnnouncementLogic());
  }
}
