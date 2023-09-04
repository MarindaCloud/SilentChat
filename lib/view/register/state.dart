import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/account_history.dart';
import 'package:flukit/flukit.dart';
class RegisterState {
  TextEditingController userName = TextEditingController(text: "demo5");
  TextEditingController passWord = TextEditingController(text: "");
  TextEditingController email = TextEditingController(text: "");
  TextEditingController verify = TextEditingController(text: "");
  final accept = false.obs;
  final accountHistoryList = <AccountHistory>[].obs;
  final showHistory = false.obs;
  RenderAfterLayout? layout;
  RegisterState() {
    ///Initialize variables
  }
}
