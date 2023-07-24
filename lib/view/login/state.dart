import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LoginState {
  TextEditingController userName = TextEditingController(text: "10011");
  TextEditingController passWord = TextEditingController(text: "demo2");
  final accept = false.obs;
  LoginState() {
    ///Initialize variables
  }
}
