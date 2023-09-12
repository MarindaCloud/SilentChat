import 'dart:io';

import 'package:flutter/material.dart';
import 'package:silentchat/entity/chat_record_data.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/socket/socket_handle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';


class ChatState {
  TextEditingController messageController = TextEditingController(text: "");
  SocketHandle? socketHandle;
  ImagePicker? picker;
  final title = "".obs;
  final receiverId = 0.obs;
  final type = 0.obs;
  final selectFile = File("").obs;
  bool sendFlag = false;
  //选择子项组件
  final chooseSubChild = false.obs;
  AnimationController? animatedController;
  Animation<double>? fadeValue;
  final chatRecordList = <ChatRecordData>[].obs;
  //用来储存记录的map
  RxMap<String,List<ChatRecordData>> recordMap = RxMap();
  //子控件类型用来拓展
  final subChildType = "".obs;
  final existsContentFlag = false.obs;
  FlutterSoundPlayer flutterSoundPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder recordSound = FlutterSoundRecorder();
  final messageList = <Message>[].obs;
  ChatState() {
    ///Initialize variables
  }
}
