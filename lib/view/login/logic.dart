import 'package:get/get.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/network/request.dart';
import 'package:silentchat/util/log.dart';
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

  /*
   * @author Marinda
   * @date 2023/6/8 16:01
   * @description 登录接口
   */
  void login() async{
    String userName = state.userName.text;
    String passWord = state.passWord.text;
    var response = UserAPI.login(userName, passWord);
    Log.i("登录响应结果: ${response}");
  }
}
