import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'state.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
        facing: CameraFacing.front,
        torchEnabled: state.showFlash.value,
        returnImage: true
    );
  }
}
