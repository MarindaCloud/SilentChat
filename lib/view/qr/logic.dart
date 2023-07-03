import 'dart:convert';

import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/util/util.dart';
import 'state.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:bot_toast/bot_toast.dart';

class QrLogic extends GetxController  {
  final QrState state = QrState();
  final SystemLogic systemLogic = Get.find<SystemLogic>();
  final SystemState systemState = Get.find<SystemLogic>().state;



  @override
  void onInit() {
    initController();
    // TODO: implement onInit
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/7/1 17:07
   * @description 初始化控制器
   */
  initController(){
    state.qrController = MobileScannerController(
        detectionSpeed: DetectionSpeed.normal,
        facing: CameraFacing.back,
        torchEnabled: state.showFlash.value,
        returnImage: true
    );
  }

  /*
   * @author Marinda
   * @date 2023/7/3 16:24
   * @description 如果扫描出该用户信息，则跳转至用户信息页面
   */
  toUserInfo(){
    String result = state.qrValue;
    //解码后的结果
    var decodeResult = GlobalUtil.decoder(result, "base64");
    Log.i("解码后的结果：${decodeResult},类型：");
    if(int.parse(decodeResult) != -1){
      int uid = int.parse(decodeResult);
      BotToast.showLoading();
      //延迟效果
      Future.delayed(Duration(seconds: 1),(){
        BotToast.closeAllLoading();
        //  视为找到相关uid
        Get.toNamed(AppPage.userInfo,arguments: uid);
        }
      );

    }else{
      BotToast.showText(text: "解析失败！未找到该用户！");
    }
  }
}
