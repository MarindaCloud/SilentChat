import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/group_announcement.dart';
import 'package:get/get.dart';
class GroupAnnouncementState {
  final groupAnnouncementList = <GroupAnnouncement>[].obs;
  Group group = Group();
  //用来储存公告的展开记录
  RxMap announcementOpenMap = RxMap<int,bool>();
  GroupAnnouncementState() {
    ///Initialize variables
  }
}
