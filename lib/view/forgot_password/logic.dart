import 'package:get/get.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/email_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:bot_toast/bot_toast.dart';
import 'state.dart';

class ForgotPasswordLogic extends GetxController {
  final ForgotPasswordState state = ForgotPasswordState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


  @override
  void dispose() {
    state.step.value = 1;
    state.verifyCode.value = "";
    super.dispose();
  }

  /*
   * @author Marinda
   * @date 2023/11/21 11:20
   * @description 发送验证码
   */
  sendVerifyCode() async{
    String number = state.accountController.text;
    try {
      User? user = await UserAPI.selectUserByNumber(int.parse(number));
      if (user == null) {
        BotToast.showText(text: "未找到该用户信息！");
        return;
      } else {
        String email = user.email ?? "";
        var verifyCode = await EmailAPI.sendVerifyCode(
            "你正在进行找回密码操作", email);
        state.verifyCode.value = verifyCode;
        toStep(2);
      }
    }catch(e){
      if(e is FormatException){
        BotToast.showText(text: "请输入正确的默讯号！");
        return;
      }
    }
  }

  /*
   * @author Marinda
   * @date 2023/11/21 14:29
   * @description 跳转至重置密码页
   */
  toResetPwd(){
    if(!validVerifyCode()){
      BotToast.showText(text: "你的验证码有误！请重试");
      return;
    }
    toStep(3);
  }

  /*
   * @author Marinda
   * @date 2023/11/21 14:14
   * @description 校验Code
   */
  bool validVerifyCode(){
    String verifyCode = state.verifyCodeController.text;
    return verifyCode == state.verifyCode.value;
  }

  /*
   * @author Marinda
   * @date 2023/11/21 11:31
   * @description 跳转步骤
   */
  toStep(int step) async{
    state.step.value = step;
  }
}
