import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/account_history.dart';
import 'package:flukit/flukit.dart';
class RegisterState {
  TextEditingController userName = TextEditingController(text: "");
  TextEditingController passWord = TextEditingController(text: "");
  TextEditingController email = TextEditingController(text: "");
  TextEditingController verify = TextEditingController(text: "");
  final accept = false.obs;
  final accountHistoryList = <AccountHistory>[].obs;
  final showHistory = false.obs;
  //验证焦点
  FocusNode verifyFocusNode = FocusNode();
  final validEmailVis = false.obs;
  final verifyCode = "".obs;
  Timer? verifyCodeTimer;
  final verifyText = "发送".obs;
  RenderAfterLayout? layout;
  RegisterState() {
    ///Initialize variables
  }
}
