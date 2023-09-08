import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/logic/cache_image_handle.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/util/overlay_manager.dart';
import 'dart:ui' as ui;
import 'state.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:crop_image/crop_image.dart';

class EditImageLogic extends GetxController {
  final EditImageState state = EditImageState();
  final userLogic = Get.find<UserLogic>();
  final userState = Get.find<UserLogic>().state;


  @override
  void onInit() {
    Log.i("初始化图片编辑");
    state.src.value = Get.arguments;
    initCropImageWidget();
  }

  initCropImageWidget(){
    state.cropWidget.value = Container(
      child: SizedBox(
        width: Get.width,
        height: Get.height / 2,
        child: CropImage(
          /// Only needed if you expect to make use of its functionality like setting initial values of
          /// [aspectRatio] and [defaultCrop].
          controller: state.controller,

          /// The image to be cropped. Use [Image.file] or [Image.network] or any other [Image].
          image: Image.network(state.src.value, fit: BoxFit.fill),
          /// The crop grid color of the outer lines. Defaults to 70% white.
          gridColor: Colors.white,

          /// The size of the corner of the crop grid. Defaults to 25.
          gridCornerSize: 5,

          /// The width of the crop grid thin lines. Defaults to 2.
          gridThinWidth: 3,

          /// The width of the crop grid thick lines. Defaults to 5.
          gridThickWidth: 5,

          /// The crop grid scrim (outside area overlay) color. Defaults to 54% black.
          scrimColor: Colors.grey.withOpacity(0.5),

          /// True: Always show third lines of the crop grid.
          /// False: third lines are only displayed while the user manipulates the grid (default).
          alwaysShowThirdLines: false,

          /// Event called when the user changes the crop rectangle.
          /// The passed [Rect] is normalized between 0 and 1.
          onCrop: (rect) => print(rect),

          /// The minimum pixel size the crop rectangle can be shrunk to. Defaults to 100.
          minimumImageSize: 30,
        ),
      ),
    );
  }

  /*
   * @author Marinda
   * @date 2023/7/20 15:23
   * @description 关闭当前处理
   */
  close(){
    Get.back();
  }


  @override
  void dispose() {
    super.dispose();
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
    int len = await pickFile?.length() ?? 0;
    double size = (len / 1000) * 0.001;
    double fileSize = double.parse(size.toStringAsFixed(3));
    if(fileSize >=5.0){
      BotToast.showText(text: "文件大小不能超过5MB!");
      return;
    }
    Log.i("选择图像的信息：大小：${fileSize}MB,mineType: ${pickFile?.mimeType}");
    String path = pickFile?.path ?? "";
    File file = File(path);
    Log.i("当前src: ${path}");
    var newController = CropController(
      /// If not specified, [aspectRatio] will not be enforced.
      aspectRatio: 1,
      /// Specify in percentages (1 means full width and height). Defaults to the full image.
      defaultCrop: Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
    );
    String key = Uuid().v4().toString();
    state.controller = newController;
    state.cropWidget.value = Container(
      key: ValueKey(key),
      child: SizedBox(
        width: Get.width,
        height: Get.height / 2,
        child: CropImage(
          /// Only needed if you expect to make use of its functionality like setting initial values of
          /// [aspectRatio] and [defaultCrop].
          controller: state.controller,
          /// The image to be cropped. Use [Image.file] or [Image.network] or any other [Image].
          image: Image.file(file,fit: BoxFit.fill,),
          /// The crop grid color of the outer lines. Defaults to 70% white.
          gridColor: Colors.white,
          /// The size of the corner of the crop grid. Defaults to 25.
          gridCornerSize: 5,
          /// The width of the crop grid thin lines. Defaults to 2.
          gridThinWidth: 3,
          /// The width of the crop grid thick lines. Defaults to 5.
          gridThickWidth: 5,
          /// The crop grid scrim (outside area overlay) color. Defaults to 54% black.
          scrimColor: Colors.grey.withOpacity(0.5),
          /// True: Always show third lines of the crop grid.
          /// False: third lines are only displayed while the user manipulates the grid (default).
          alwaysShowThirdLines: false,
          /// Event called when the user changes the crop rectangle.
          /// The passed [Rect] is normalized between 0 and 1.
          onCrop: (rect) => (){},
          /// The minimum pixel size the crop rectangle can be shrunk to. Defaults to 100.
          minimumImageSize: 30,
        ),
      ),
    );
    state.cropWidget.refresh();
  }

  /*
   * @author Marinda
   * @date 2023/9/6 17:13
   * @description 保存
   */
  save() async{
    //修改了一下最大Size比例因子，不然出来的图像大小很高导致上传速度变慢&文件大小过大
    ui.Image bitMap = await state.controller.croppedBitmap(maxSize: 1000);
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
    User cloneUser = User.fromJson(userState.user.toJson());
    cloneUser.portrait = result;
    userState.user.value.portrait = result;
    print('用户信息：${userState.user.value.toJson()}');
    Log.i("当前头像地址：${cloneUser.portrait},更新头像地址: ${result}");
    var updResult = await UserAPI.updateUser(userState.user.value);
    if(!updResult){
      BotToast.showText(text: "头像修改失败！");
    }
    BotToast.showText(text: "修改头像成功！");
    await CacheImageHandle.addImageCache(result);
    userState.user.value = cloneUser;
    userState.user.refresh();
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
