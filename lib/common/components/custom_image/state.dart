import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
class CustomImageState {
  final src = "".obs;
  Function? saveFun;
  GlobalKey globalKey = GlobalKey();
  PhotoViewController photoViewController = PhotoViewController(initialScale: 0);
  final customOffset = Offset.zero.obs;
  final showCustomWidget = false.obs;
  final rectSize = Size(Get.width - 5,250).obs;
  final scale = 1.0.obs;
  double maxScale = 1.1;
  double minScale = 0.6;
  //当前方向
  String customDirection = "";
  // 起始点
  Offset? startOffset;
  CustomImageState() {
    ///Initialize variables
  }
}
