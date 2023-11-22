import 'package:get/get.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/app_page.dart';

import 'state.dart';

/**
 * @author Marinda
 * @date 2023/11/21 15:06
 * @description 个人空间
 */
class MySpaceLogic extends GetxController {
  final MySpaceState state = MySpaceState();
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;

  @override
  void onInit() {
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/11/21 15:48
   * @description 跳转至发布动态页
   */
  toReleaseDynamicPage() async{
    await Get.toNamed(AppPage.releaseSpaceDynamic);
  }

}
