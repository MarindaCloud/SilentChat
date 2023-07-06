import 'package:silentchat/entity/verify.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/verify_view_info.dart';
class VerifyState {
  final verifyList = <Verify>[].obs;
  dynamic value;
  final verifyViewInfo = <VerifyViewInfo>[].obs;
  //用来储存用户的操作记录 对于每个用户的请求情况
  Map<int,int> userControlMap = {};
  VerifyState() {
    ///Initialize variables
  }
}
