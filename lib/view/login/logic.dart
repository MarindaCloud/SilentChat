import 'package:get/get.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/view/message/view.dart';

import 'state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/5/25 14:49
   * @description 跳转至index页
   */
  void toIndex(){
    Get.toNamed(AppPage.index,arguments: MessagePage());
  }
}
