import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/group_announcement.dart';
import 'package:silentchat/entity/group_user_info.dart';
import 'package:silentchat/entity/user.dart';
class EditGroupInfoState {
  final group = Group().obs;
  //群员详情列表
  final userInfoList = <GroupUserInfo>[].obs;
  //用户列表
  final userList = <User>[].obs;
  final groupAnnouncementList = <GroupAnnouncement>[].obs;
  //校验是否是群管理
  final validAdminIdentity = false.obs;
  //群昵称
  final nickName = "".obs;
  //群公告
  final newAnnounment= "".obs;
  EditGroupInfoState() {
    ///Initialize variables
  }
}
