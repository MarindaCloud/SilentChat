import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/account_history.dart';
import 'package:flukit/flukit.dart';
class LoginState {
  TextEditingController userName = TextEditingController(text: "demo5");
  TextEditingController passWord = TextEditingController(text: "demo5");
  final accept = false.obs;
  final accountHistoryList = <AccountHistory>[].obs;
  final showHistory = false.obs;
  final type = 0.obs;
  RenderAfterLayout? layout;
  LoginState() {
    ///Initialize variables
  }
}
