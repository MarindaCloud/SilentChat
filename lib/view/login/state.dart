import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LoginState {
  TextEditingController userName = TextEditingController(text: "10010");
  TextEditingController passWord = TextEditingController(text: "demo");
  final accept = false.obs;
  LoginState() {
    ///Initialize variables
  }
}
