import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ForgotPasswordState {
  TextEditingController accountController = TextEditingController(text: "");
  TextEditingController verifyCodeController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController repeatPasswordController = TextEditingController(text: "");
  final step = 1.obs;
  final verifyCode = "".obs;
  ForgotPasswordState() {
    ///Initialize variables
  }
}
