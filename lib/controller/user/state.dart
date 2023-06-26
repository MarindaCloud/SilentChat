import 'package:silentchat/entity/user.dart';
import 'package:get/get.dart';
class UserState {
  final user = User().obs;
  final uid = 0.obs;
  final friendUserList = <User>[].obs;
  UserState() {
    ///Initialize variables
  }
}
