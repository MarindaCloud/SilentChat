import 'package:silentchat/entity/announcement_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
class EditAnnouncementState {
  AnnouncementView announcementView = AnnouncementView();
  TextEditingController textController = TextEditingController(text: "");
  final imgSrc = "".obs;
  ImagePicker imagePicker = ImagePicker();
  EditAnnouncementState() {

    ///Initialize variables
  }
}
