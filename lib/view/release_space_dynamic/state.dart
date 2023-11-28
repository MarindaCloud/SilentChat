import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:silentchat/entity/space_dynamic.dart';
class ReleaseSpaceDynamicState {
  final imgPath = <String>[].obs;
  ImagePicker imagePicker = ImagePicker();
  TextEditingController contentController = TextEditingController(text: "");
  SpaceDynamic? spaceDynamic;
  ReleaseSpaceDynamicState() {
    ///Initialize variables
  }
}
