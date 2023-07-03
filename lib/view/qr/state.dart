import 'package:flutter/material.dart';
// import "package:flutter_scankit/flutter_scankit.dart";
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:get/get.dart';
class QrState {
  //请求结果
  final qrValue = "".obs;
  //前置后置
  final viewType = true.obs;
  // 是否打开闪光灯
  final showFlash = false.obs;
  MobileScannerController qrController = MobileScannerController();
  QrState() {
    ///Initialize variables
  }
}
