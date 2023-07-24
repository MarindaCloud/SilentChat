import 'package:get/get.dart';
import 'package:silentchat/view/append_group/logic.dart';

import 'logic.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessageLogic());
  }
}
