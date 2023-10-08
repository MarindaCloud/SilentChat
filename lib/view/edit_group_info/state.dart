import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/group_user_info.dart';
import 'package:silentchat/entity/user.dart';
class EditGroupInfoState {
  final group = Group().obs;
  //群员详情列表
  final userInfoList = <GroupUserInfo>[].obs;
  //用户列表
  final userList = <User>[].obs;
  EditGroupInfoState() {
    ///Initialize variables
  }
}
