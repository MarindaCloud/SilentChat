import 'package:get/get.dart';
import 'package:silentchat/entity/friends_view_info.dart';
import 'package:silentchat/entity/user.dart';
class ContactState {
  final showAddFriends = false.obs;
  final page = 0.obs;
  List<String> letterList = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
  final chooseLetter = "A".obs;
  //用来储存朋友缓存信息，字母 & 用户信息
  final friendsCacheMap = RxMap<String,List<FriendsViewInfo>>();
  //朋友视图列表
  final friendsViewInfoList = <FriendsViewInfo>[].obs;
  ContactState() {
    ///Initialize variables
  }
}
