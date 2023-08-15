import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LoginState {
  TextEditingController userName = TextEditingController(text: "demo5");
  TextEditingController passWord = TextEditingController(text: "demo5");
  final accept = false.obs;
  LoginState() {
    ///Initialize variables
  }
}
