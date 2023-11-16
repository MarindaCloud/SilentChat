import 'package:silentchat/entity/announcement_view.dart';
import 'package:silentchat/entity/group.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class AppendAnnouncementState {
  Group group = Group();
  TextEditingController contentController = TextEditingController(text: "");
  final imgPath = "".obs;
  ImagePicker imagePicker = ImagePicker();
  final viewAnnouncement = AnnouncementView().obs;
  AppendAnnouncementState() {
    ///Initialize variables
  }
}
