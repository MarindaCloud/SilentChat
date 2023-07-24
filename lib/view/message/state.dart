import 'package:get/get.dart';
import 'package:silentchat/entity/message.dart';
class MessageState {
  final showTools = false.obs;
  //消息视图Map
  final messageViewMap = RxMap<String,Map<int,Message>>();
  MessageState() {
    ///Initialize variables
  }
}
