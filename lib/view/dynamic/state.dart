import 'package:silentchat/entity/space_dynamic.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/user.dart';
class DynamicState {
  final dynamicList = <SpaceDynamic>[].obs;
  Map<int,User> dynamicUserMap = {};
  DynamicState() {
    ///Initialize variables
  }
}
