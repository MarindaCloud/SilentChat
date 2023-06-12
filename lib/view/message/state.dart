import 'package:get/get.dart';
import 'package:silentchat/entity/message.dart';
class MessageState {
  final showTools = false.obs;
  final messageRecordMessage = [];
  //消息视图Map
  final messageViewMap = RxMap<String,Message>();
  MessageState() {
    ///Initialize variables
  }
}
