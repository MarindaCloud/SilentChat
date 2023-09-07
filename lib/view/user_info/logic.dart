import 'dart:io';

import 'package:get/get.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/util/overlay_manager.dart';
import 'state.dart';

import 'package:image_picker/image_picker.dart';
/**
 * @author Marinda
 * @date 2023/6/21 14:17
 * @description 用户信息
 */
class UserInfoLogic extends GetxController {
  final UserInfoState state = UserInfoState();
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;

  @override
  void onInit() {
    //处理头像变更更新
    ever(userState.user, (element) {
      userState.user.value = element;
    });
    var uid = Get.arguments;
    loadUserInfo(uid);
  }

  /*
   * @author Marinda
   * @date 2023/7/20 14:35
   * @description 显示修改头像组件
   */
  showUpdatePortrait(){
    Get.toNamed(AppPage.editImage,arguments: userState.user.value.portrait);
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
