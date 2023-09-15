import 'package:silentchat/entity/friends_view_info.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/entity/silent_chat_entity.dart';
import 'package:silentchat/entity/user.dart';
import 'package:get/get.dart';
class UserState {
  final user = User().obs;
  final uid = 0.obs;
  final friendUserList = <User>[].obs;
  final joinGroupList = <Group>[].obs; String deviceName = "";
  //未读消息map
  RxMap<SilentChatEntity,List<Message>> messageMap = RxMap();
  //备注名称Map
  RxMap<int,String> notesMap = RxMap();
  UserState() {
    ///Initialize variables
  }
}
