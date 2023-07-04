import 'package:silentchat/entity/verify.dart';
import 'package:get/get.dart';
class VerifyState {
  final verifyList = <Verify>[].obs;
  dynamic value;
  //这里预留一下，明天用来处理回显的数据，转Map，因为显示在View中的数据不能async
  VerifyState() {
    ///Initialize variables
  }
}
