import 'package:get/get.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/entity/silent_chat_entity.dart';
class MessageState {
  final showTools = false.obs;
  //消息视图Map
  final messageViewMap = RxMap<String,Map<int,Message>>();
  //消息目标对象视图Map
  final messageMap = RxMap<SilentChatEntity,Message>();
  MessageState() {
    ///Initialize variables
  }
}
