import 'package:get/get.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:silentchat/util/log.dart';
import 'state.dart';
/**
 * @author Marinda
 * @date 2023/6/21 14:17
 * @description 用户信息
 */
class UserInfoLogic extends GetxController {
  final UserInfoState state = UserInfoState();

  @override
  void onInit() {
    var uid = Get.arguments;
    loadUserInfo(uid);
  }

  /*
   * @author Marinda
   * @date 2023/6/21 14:44
   * @description 加载用户信息
   */
  void loadUserInfo(int uid) async{
    try{
      User user = await UserAPI.selectByUid(uid);
      state.user.value = user;
      Log.i("用户信息：${user.toJson()}");
    }catch(e){
      BotToast.showText(text: "未找到该用户的详情数据");
      Log.e(e);
    }
  }
}
