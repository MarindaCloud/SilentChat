import 'package:get/get.dart';
import 'package:silentchat/db/db_manager.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/entity/silent_chat_entity.dart';
class MessageState {
  final showTools = false.obs;
  //消息视图Map
  final messageViewMap = RxMap<SilentChatEntity,Message>();
  //用来处理手势左滑的消息列表
  final onHorizontalDragMessageList = <Message>[].obs;
  MessageState() {
    ///Initialize variables
  }
}
