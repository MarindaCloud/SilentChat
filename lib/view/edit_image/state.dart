import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:crop_image/crop_image.dart';
import 'package:image_picker/image_picker.dart';


class EditImageState {
  final src = "".obs;
  Function? saveFun;
  GlobalKey globalKey = GlobalKey();
  PhotoViewController photoViewController = PhotoViewController(initialScale: 0);
  final customOffset = Offset.zero.obs;
  final showCustomWidget = true.obs;
  final rectSize = Size(Get.width - 5,250).obs;
  final scale = 1.0.obs;
  double maxScale = 1.1;
  double minScale = 0.6;
  final cropWidget = Container().obs;
  CropController controller = CropController(
    /// If not specified, [aspectRatio] will not be enforced.
    aspectRatio: 1,
    /// Specify in percentages (1 means full width and height). Defaults to the full image.
    defaultCrop: Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );
  //当前方向
  String customDirection = "";
  // 起始点
  Offset? startOffset;
  //选择
  ImagePicker imagePicker = ImagePicker();
  CustomImageState() {
    ///Initialize variables
  }
}
