import 'package:get/get.dart';
import 'package:silentchat/view/message/logic.dart';

import 'logic.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexLogic());
    Get.lazyPut(() => MessageLogic());
  }
}
