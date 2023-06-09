import 'package:silentchat/entity/friend.dart';
import 'package:silentchat/entity/user.dart';
import 'package:get/get.dart';
/**
 * @author Marinda
 * @date 2023/6/9 17:32
 * @description 系统state
 */
class SystemState{
  User user = User();
  final friendList = <Friend>[].obs;
}