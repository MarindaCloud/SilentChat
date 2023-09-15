import 'package:get/get.dart';
import 'package:silentchat/entity/user.dart';
class EditFriendsInfoState {
  final user = User().obs;
  String nickName = "";
  final isRemove = false.obs;
  EditFriendsInfoState() {
    ///Initialize variables
  }
}
