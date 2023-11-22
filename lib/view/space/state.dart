import 'package:silentchat/entity/space_dynamic_view.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/user.dart';
class SpaceState {
  final dynamicViewInfoList = <SpaceDynamicView>[].obs;
  final  moreLikesList = <User>[].obs;
  SpaceState() {
    ///Initialize variables
  }
}
