import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/space_dynamic_info_view.dart';
import 'package:silentchat/entity/space_dynamic_view.dart';
import 'package:silentchat/entity/user.dart';
class MySpaceState {
  final dynamicViewInfoList = <SpaceDynamicView>[].obs;
  final moreLikesList = <User>[].obs;
  final  user = User().obs;
  MySpaceState() {
    ///Initialize variables
  }
}
