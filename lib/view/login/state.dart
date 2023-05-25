import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LoginState {
  TextEditingController userName = TextEditingController(text: "");
  TextEditingController passWord = TextEditingController(text: "");
  final accept = false.obs;
  LoginState() {
    ///Initialize variables
  }
}
