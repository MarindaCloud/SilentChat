import 'package:get/get.dart';
import 'package:flutter/material.dart';
class EditUserInfoState {
  TextEditingController userNameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController signatureController = TextEditingController(text: "");
  TextEditingController locationController = TextEditingController(text: "");
  final sex = "".obs;
  final year = "".obs;
  final month = "".obs;
  final day = "".obs;
  List<int> years = [];
  List<int> months = [];
  final days = <int>[].obs;
  EditUserInfoState() {
    ///Initialize variables
  }
}
