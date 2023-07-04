import 'package:get/get.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/network/request.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/message/view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;
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
    APIResult apiResult = await UserAPI.login(userName, passWord);
    User user = User.fromJson(apiResult.data["user"]);
    if(apiResult.code == 400){
      BotToast.showText(text: "登录失败，账号或密码错误！");
      return;
    }
    userState.uid.value = user?.id ?? -1;
    userState.user.value = user;
    Log.i("用户信息：${user.toJson()}");
    toIndex();
    Log.i("登录响应结果: ${apiResult}");
  }
}
