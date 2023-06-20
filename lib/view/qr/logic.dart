import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'state.dart';


class QrLogic extends GetxController  {
  final QrState state = QrState();
  final SystemLogic systemLogic = Get.find<SystemLogic>();
  final SystemState systemState = Get.find<SystemLogic>().state;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/6/20 15:08
   * @description 显示扫码器
   */
  void showParseQRCode(){

  }




}
