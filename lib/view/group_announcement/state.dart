import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/group_announcement.dart';
import 'package:get/get.dart';
class GroupAnnouncementState {
  final groupAnnouncementList = <GroupAnnouncement>[].obs;
  Group group = Group();
  GroupAnnouncementState() {
    ///Initialize variables
  }
}
