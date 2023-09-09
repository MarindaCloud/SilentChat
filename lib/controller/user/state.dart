import 'package:silentchat/entity/friends_view_info.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/user.dart';
import 'package:get/get.dart';
class UserState {
  final user = User().obs;
  final uid = 0.obs;
  final friendUserList = <User>[].obs;
  final joinGroupList = <Group>[].obs; String deviceName = "";
  UserState() {
    ///Initialize variables
  }
}
