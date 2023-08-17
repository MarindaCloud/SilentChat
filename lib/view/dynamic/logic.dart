import 'package:get/get.dart';
import 'package:silentchat/entity/app_page.dart';

import 'state.dart';

class DynamicLogic extends GetxController {
  final DynamicState state = DynamicState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/8/17 16:22
   * @description 跳转至Space
   */
  toSpace(){
    Get.toNamed(AppPage.space);
  }
}
