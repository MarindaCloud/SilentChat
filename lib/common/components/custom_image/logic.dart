import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/util/overlay_manager.dart';
import 'dart:ui' as ui;
import 'state.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:image_picker/image_picker.dart';

class CustomImageLogic extends GetxController {
  final CustomImageState state = CustomImageState();
  final userLogic = Get.find<UserLogic>();
  final userState = Get.find<UserLogic>().state;

  CustomImageLogic(String src,Function saveFun){
    state.src.value = src;
    state.saveFun = saveFun;
  }


  @override
  void onClose() {
    close();
    super.dispose();
  }


  @override
  void dispose() {
    close();
    super.dispose();
  }

  /*
   * @author Marinda
   * @date 2023/7/20 15:23
   * @description 关闭当前处理
   */
  close(){
    OverlayManager().removeOverlay("customImage");
    state.rectSize.value = Size.zero;
    state.customDirection = "";
    state.showCustomWidget.value = false;
    state.customOffset.value = Offset.zero;
  }

  /*
   * @author Marinda
   * @date 2023/9/6 17:13
   * @description 旋转
   */
  rotate(){
    state.controller.rotateLeft();
  }

  pickPortrait() async{
    XFile? pickFile = await state.imagePicker.pickImage(source: ImageSource.gallery);
    String path = pickFile?.path ?? "";
    state.src.value = path;
    File file = File(path);
    Log.i("该File是否存在：${file.existsSync()}");
    state.src.refresh();
    // var portraitSrc = await UserAPI.uploadPortrait(file, userState.user.value);
    // Log.i("头像地址：${portraitSrc}");
    // User user = userState.user.value;
    // User newUser = User.fromJson(user.toJson());
    // Log.i("该User: ${newUser.toJson()}");
    // newUser.portrait = portraitSrc;
    // var updResult = await UserAPI.updateUser(user);
    // if(!updResult){
    //   BotToast.showText(text: "头像修改失败！");
    // }
    // BotToast.showText(text: "修改头像成功！");
  }

  /*
   * @author Marinda
   * @date 2023/9/6 17:13
   * @description 保存
   */
  save() async{
    ui.Image bitMap = await state.controller.croppedBitmap();
    var data = await bitMap.toByteData(format: ImageByteFormat.png);
    var bytes = data!.buffer.asUint8List();
    var dir = await path.getApplicationDocumentsDirectory();
    var uuid = Uuid().v4();
    var filePath = "${dir.path}/${uuid}.png";
    File file = File(filePath);
    await file.writeAsBytes(bytes);
    Log.i("文件地址：${filePath},是否存在:${file.existsSync()}");
    var result = await UserAPI.uploadPortrait(file,userState.user.value);

    Log.i("上传结果：${result}");
    if(result!=null){
      BotToast.showText(text: "头像更新成功！");
    }
    User cloneUser = User.fromJson(userState.user.toJson());
    cloneUser.portrait = result;
    Log.i("当前头像地址：${cloneUser.portrait},更新头像地址: ${result}");
    userState.user.value = cloneUser;
    userState.user.refresh();
    Get.forceAppUpdate();
  }


  /*
   * @author Marinda
   * @date 2023/7/21 14:34
   * @description 显示边框裁剪
   */

  showCustomWidget(){
    state.showCustomWidget.value = !state.showCustomWidget.value;
    Log.i("显示边框裁剪");
  }


}
