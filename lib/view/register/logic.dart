import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/account_history.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/email_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/network/api/verify_api.dart';
import 'package:silentchat/util/log.dart';
import 'package:bot_toast/bot_toast.dart';
import 'state.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_storage/get_storage.dart';


class RegisterLogic extends GetxController {
  final RegisterState state = RegisterState();
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;
  final storage = GetStorage();

  @override
  void onInit() {
    registerEmailFocusNodeListener();
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/9/5 14:37
   * @description 注册邮箱焦点监听器
   */
  registerEmailFocusNodeListener(){
    state.verifyFocusNode.addListener(() {
      if(!state.verifyFocusNode.hasFocus){
        //  获取焦点
        //  失焦
        RegExp regExp = RegExp(r'\w+@\w+(\.\w+)+');
        String email = state.email.text;
        if(email == ""){
          state.validEmailVis.value = false;
        }
        //匹配邮箱
        if(regExp.hasMatch(email)){
          state.validEmailVis.value = false;
        }else{
          state.validEmailVis.value = true;
        }
      }});
  }
  
  /*
   * @author Marinda
   * @date 2023/9/5 14:51
   * @description 添加验证码定时器
   */
  addVerifyCodeTimer(){
    int seconds = 10;
    state.verifyCodeTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      print("当前秒数: ${seconds}");
      if(seconds<=0){
        state.verifyCodeTimer!.cancel();
        state.verifyCodeTimer = null;
        state.verifyText.value = "发送";
        Log.i("定时器结束！");
        return;
      }
      state.verifyText.value = seconds.toString();
      seconds--;

    });
  }


  /*
   * @author Marinda
   * @date 2023/8/15 10:26
   * @description 获取设备名称
   */
  void getDeviceName() async{
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String deviceName = "";
    if(GetPlatform.isAndroid){
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      deviceName = androidDeviceInfo.model;
    }else{
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      deviceName = iosDeviceInfo.name;
    }
    userState.deviceName = deviceName;
    Log.i("设备名称: ${deviceName}");

  }

  /*
   * @author Marinda
   * @date 2023/9/5 14:13
   * @description 发送邮件注册码
   */
  sendVerifyCode() async{
    if(state.verifyCodeTimer != null || state.verifyText.value != "发送"){
      print("不符合规则！");
      return;
    }
    String emailValue = state.email.text;
    if(state.validEmailVis.value || emailValue == "")return;
    // 发送验证码
    String verifyCode = await EmailAPI.sendVerifyCode("默讯注册验证码",emailValue);
    print('验证码：${verifyCode}');
    state.verifyCode.value = verifyCode;
    addVerifyCodeTimer();
  }

  /*
   * @author Marinda
   * @date 2023/6/8 16:01
   * @description 登录接口
   */
  void register() async{
    String userName = state.userName.text;
    String passWord = state.passWord.text;
    String email = state.email.text;
    String verifyText = state.verify.text;
    if(userName == "" || passWord == "" || email == ""){
      BotToast.showText(text: "注册信息不能为空！");
      return;
    }
    if(verifyText != state.verifyCode.value){
      BotToast.showText(text: "验证码有误！");
      return;
    }
    User user = User(username: userName,password: passWord,email: email);
    APIResult apiResult = await UserAPI.register(user);
    if(apiResult.code == 400){
      BotToast.showText(text: apiResult.msg ?? "");
      return;
    }
    BotToast.showText(text: "注册成功！");
    Get.back();
  }
}
