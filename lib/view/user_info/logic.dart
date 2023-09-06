import 'dart:io';

import 'package:get/get.dart';
import 'package:silentchat/common/components/custom_image/view.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
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
    var uid = Get.arguments;
    loadUserInfo(uid);
  }

  /*
   * @author Marinda
   * @date 2023/7/7 17:05
   * @description 选择头像
   */
  pickPortrait() async{
    XFile? pickFile = await state.imagePicker.pickImage(source: ImageSource.gallery);
    String path = pickFile?.path ?? "";
    File file = File(path);
    Log.i("该File是否存在：${file.existsSync()}");
    var portraitSrc = await UserAPI.uploadPortrait(file, userState.user.value);
    Log.i("头像地址：${portraitSrc}");
    User user = userState.user.value;
    User newUser = User.fromJson(user.toJson());
    Log.i("该User: ${newUser.toJson()}");
    newUser.portrait = portraitSrc;
    var updResult = await UserAPI.updateUser(user);
    if(!updResult){
      BotToast.showText(text: "头像修改失败！");
    }
    BotToast.showText(text: "修改头像成功！");
  }


  /*
   * @author Marinda
   * @date 2023/7/20 14:35
   * @description 显示修改头像组件
   */
  showUpdatePortrait(){
    OverlayManager().createOverlay("customImage", CustomImageComponent(state.user.value.portrait ?? "", (){Log.i("保存");}));
    Log.i("显示修改头像组件！");
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
