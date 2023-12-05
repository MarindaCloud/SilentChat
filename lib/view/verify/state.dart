import 'package:silentchat/entity/group_verify.dart';
import 'package:silentchat/entity/verify.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/verify_group_view_info.dart';
import 'package:silentchat/entity/verify_view_info.dart';
class VerifyState {
  final verifyList = <Verify>[].obs;
  dynamic value;
  final verifyFriendsViewInfo = <VerifyViewInfo>[].obs;
  final verifyGroupViewInfo = <VerifyGroupViewInfo>[].obs;
  //用来储存用户的操作记录 对于每个用户的请求情况
  Map<int,int> userControlMap = {};
  Map<int,int> groupControlMap = {};
  VerifyState() {
    ///Initialize variables
  }
}
