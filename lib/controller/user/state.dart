import 'package:silentchat/entity/friends_view_info.dart';
import 'package:silentchat/entity/user.dart';
import 'package:get/get.dart';
class UserState {
  final user = User().obs;
  final uid = 0.obs;
  final friendsViewInfoList = <FriendsViewInfo>[].obs;
  final friendUserList = <User>[].obs;
  String deviceName = "";
  UserState() {
    ///Initialize variables
  }
}
