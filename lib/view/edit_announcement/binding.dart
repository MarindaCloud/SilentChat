import 'package:get/get.dart';

import 'logic.dart';

class EditAnnouncementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditAnnouncementLogic());
  }
}
