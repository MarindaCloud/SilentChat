import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/expansion/image_path.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silentchat/entity/space_dynamic.dart';
import 'package:silentchat/entity/space_dynamic_info.dart';
import 'package:silentchat/entity/space_user_info.dart';
import 'package:silentchat/network/api/common_api.dart';
import 'package:silentchat/network/api/space_api.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'state.dart';
import 'package:bot_toast/bot_toast.dart';
/**
 * @author Marinda
 * @date 2023/11/21 15:29
 * @description 发布空间动态
 */
class ReleaseSpaceDynamicLogic extends GetxController {
  final ReleaseSpaceDynamicState state = ReleaseSpaceDynamicState();
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;


  @override
  void onInit() {
    var args = Get.arguments;
    if(args != null){
      state.spaceDynamic = Get.arguments;
      loadDynamicContentInfo();
    }
    // TODO: implement onInit
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/11/28 13:51
   * @description 加载动态内容详情
   */
  loadDynamicContentInfo(){
    state.contentController.text = state.spaceDynamic?.content ?? "";
    if(state.spaceDynamic?.image != null && state.spaceDynamic?.image!=""){
      var decodeImageList = json.decode(state.spaceDynamic?.image ?? "");
      if(decodeImageList is List){
        state.imgPath.value = decodeImageList.map((e) => e.toString()).toList();
      }
    }

  }


  /*
   * @author Marinda
   * @date 2023/11/22 11:39
   * @description 构建选择图像列表
   */
  buildPickImageList(){
    var list = state.imgPath.value;
    var widgetList = <Widget>[];
    for(int i = 0;i<list.length;i++){
      var element = list[i];
      var widget = InkWell(
        onTap: ()=>pickImage(),
        child: Container(
          height: 500.rpx,
          width: 500.rpx,
          margin: EdgeInsets.only(bottom: 50.rpx,right: 50.rpx),
          child: Stack(
            children: [
              SizedBox.expand(
                child: element.startsWith("http") ? Image.network(
                    element,
                    fit: BoxFit.fill) : Image.file(
                    File(element),
                    fit: BoxFit.fill),
              ),
              Positioned(
                  right: 0.rpx,
                  top: 0.rpx,
                  child: InkWell(
                    child: SizedBox(
                      width: 100.rpx,
                      height: 100.rpx,
                      child: Image.asset(
                        "shanchu2.png".icon, fit: BoxFit.fill,
                        color: Colors.red,),
                    ),
                    onTap: () => removeImage(i),
                  )
              ),
            ],
          ),
        ),
      );
      widgetList.add(widget);
    }
    return widgetList;
  }

  pickImage() async{
    List<String> list = [];
    try {
      List<XFile?> imgElement = await state.imagePicker.pickMultiImage();
      imgElement.forEach((element) {
        list.add(element?.path ?? "");
      });
      state.imgPath.value = list;
    }catch(e){
      if(e is PlatformException){
        BotToast.showText(text: "该图像格式暂不支持！");
        return;
      }

    }
  }

  /*
   * @author Marinda
   * @date 2023/11/22 14:18
   * @description 删除图像
   */
  removeImage(int index){
    state.imgPath.removeAt(index);
  }


  /*
   * @author Marinda
   * @date 2023/11/22 10:32
   * @description 清空内容
   */
  resetContent(){
    state.imgPath.value = [];
    state.contentController.text = "";
  }
  /*
   * @author Marinda
   * @date 2023/11/28 14:57
   * @description 返回处理
   */

  back(){
    if(state.spaceDynamic!= null){
      Get.back(result: state.spaceDynamic);
    }else{
      Get.back();
    }
  }

  static uploadPickImage(List<String> imgList) async{
    List<String> uploadImageList = [];
    for(var element in imgList){
      File file = File(element);
      if(file.existsSync()){
        String src = await CommonAPI.uploadFile(file, "dynamic");
        uploadImageList.add(src);
      }
    }
    return uploadImageList;
  }

  /*
   * @author Marinda
   * @date 2023/11/22 10:33
   * @description 发布动态
   */
  submit() async {
    Log.i("提交！");
    String content = state.contentController.text;
    String deviceName = userState.deviceName;
    //校验是否是空间编辑页面进来的
    if(state.spaceDynamic != null){
      //如果都为空则不做任何处理
      if(state.imgPath.isEmpty && content == ""){
        BotToast.showText(text: "修改信息为空！");
        return;
      }
      SpaceDynamic spaceDynamic = SpaceDynamic(
          id: state.spaceDynamic!.id,
          uid: state.spaceDynamic!.uid,
          device: state.spaceDynamic!.device,
          content: content,
          time: DateTime.now().toString());
      //没选择图像
      if(state.imgPath.isEmpty){
        spaceDynamic.image = state.spaceDynamic!.image;
      }else{
        String imgInfo = json.encode(state.imgPath.value);
        var element = state.imgPath.firstWhereOrNull((element) => element.startsWith("http"));
        if(element == null){
          var uploadImageList = await compute(uploadPickImage, state.imgPath.value);
          imgInfo = json.encode(uploadImageList);
        }
        spaceDynamic.image = imgInfo;
      }
      int dynamicId = await SpaceAPI.updateSpaceDynamic(spaceDynamic);
      if (dynamicId >= 1) {
        BotToast.showText(text: "修改成功！");
        state.spaceDynamic = spaceDynamic;
      } else {
        BotToast.showText(text: "修改失败！");
      }
      return;
    }
    var uploadImageList = await compute(uploadPickImage, state.imgPath.value);
    String imgInfo = json.encode(uploadImageList);
    SpaceDynamic spaceDynamic = SpaceDynamic(uid: userState.uid.value,
        device: deviceName,
        content: content,
        time: DateTime.now().toString(),
        image: imgInfo);
    SpaceUserInfo? spaceUserInfo = await SpaceAPI.selectUserSpaceByUid();
    if (spaceUserInfo == null) {
      BotToast.showText(text: "发布出现异常,空间不存在！");
      return;
    }
    int spaceId = spaceUserInfo.spaceId ?? -1;
    int dynamicId = await SpaceAPI.insertSpaceDynamic(spaceDynamic);
    SpaceDynamicInfo spaceDynamicInfo = SpaceDynamicInfo(
        spaceId: spaceId, dynamicId: dynamicId);
    int result = await SpaceAPI.insertSpaceDynamicInfo(spaceDynamicInfo);
    if (result >= 1) {
      BotToast.showText(text: "发布成功！");
      resetContent();
    } else {
      BotToast.showText(text: "发布失败！");
    }
  }
}
