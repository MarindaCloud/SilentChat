import 'package:flutter/material.dart';
import 'package:silentchat/entity/chat_record_data.dart';
import 'package:silentchat/socket/socket_handle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class ChatState {
  TextEditingController messageController = TextEditingController(text: "");
  SocketHandle? socketHandle;
  ImagePicker? picker;
  final title = "".obs;
  //录音
  final chooseRecording = false.obs;
  AnimationController? animatedController;
  Animation<double>? fadeValue;
  final chatRecordList = <ChatRecordData>[].obs;
  //用来储存记录的map
  RxMap<String,List<ChatRecordData>> recordMap = RxMap();

  final existsContentFlag = false.obs;
  Map<String,int> args = {};
  ChatState() {
    ///Initialize variables
  }
}
