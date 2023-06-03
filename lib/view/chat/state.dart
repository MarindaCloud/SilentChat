import 'package:flutter/material.dart';
import 'package:silentchat/socket/socket_handle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
class ChatState {
  SocketHandle? socketHandle;
  ImagePicker? picker;
  //录音
  final chooseRecording = false.obs;
  AnimationController? animatedController;
  Animation<double>? fadeValue;
  ChatState() {
    ///Initialize variables
  }
}
