import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/util/overlay_manager.dart';

import 'state.dart';

class CustomImageLogic extends GetxController {
  final CustomImageState state = CustomImageState();

  CustomImageLogic(String src,Function saveFun){
    state.src.value = src;
    state.saveFun = saveFun;
  }


  @override
  void onClose() {
    super.dispose();
    close();
  }

  /*
   * @author Marinda
   * @date 2023/7/20 15:23
   * @description 关闭当前处理
   */
  close(){
    OverlayManager().removeOverlay("customImage");
    state.rectSize.value = Size.zero;
    state.customDirection = "";
    state.showCustomWidget.value = false;
    state.customOffset.value = Offset.zero;
  }

  onTapDown(TapDownDetails details){
    var position = details.localPosition;
    // double dx = position.dx;
    // double dy = position.dy;
    // int number = 15;
    state.startOffset = details.localPosition;
    var currentOffset = state.customOffset.value;
    var rectSize = state.rectSize.value;
    //当前的矩形情况
    var currentRect = Rect.fromLTWH(currentOffset.dx,currentOffset.dy, rectSize.width, rectSize.height);
    state.customDirection = calculatePositionInRect(currentRect,position,15);
    Log.i("起始点：${state.startOffset}");
    Log.i("目标位置：${state.customDirection}");
  }


  /*
   * @author Marinda
   * @date 2023/7/21 17:17
   * @description 计算方法
   */
  String calculatePositionInRect(Rect rect, Offset offset, double tolerance) {
    double left = rect.left;
    double right = rect.right;
    double top = rect.top;
    double bottom = rect.bottom;

    if (offset.dx >= left - tolerance && offset.dx <= left + tolerance &&
        offset.dy >= top - tolerance && offset.dy <= top + tolerance) {
      return 'TopLeft';
    } else if (offset.dx >= right - tolerance && offset.dx <= right + tolerance &&
        offset.dy >= top - tolerance && offset.dy <= top + tolerance) {
      return 'TopRight';
    } else if (offset.dx >= left - tolerance && offset.dx <= left + tolerance &&
        offset.dy >= bottom - tolerance && offset.dy <= bottom + tolerance) {
      return 'BottomLeft';
    } else if (offset.dx >= right - tolerance && offset.dx <= right + tolerance &&
        offset.dy >= bottom - tolerance && offset.dy <= bottom + tolerance) {
      return 'BottomRight';
    }

    return 'Inside';
  }


  /*
   * @author Marinda
   * @date 2023/7/21 14:34
   * @description 缩放移动处理
   */
  scaleUpdate(ScaleUpdateDetails details){
    if(state.showCustomWidget.value){
      var currentOffset = state.customOffset.value;
      var rectSize = state.rectSize.value;
      //当前的矩形情况
      var currentRect = Rect.fromLTWH(currentOffset.dx,currentOffset.dy, rectSize.width, rectSize.height);
      var customOffset = Offset.zero;
      var newSize = Size.zero;
      Log.i("当前方向：${state.customDirection}");
    // 根据方位调整矩形的位置和大小
      switch (state.customDirection) {
        case "TopLeft":
          customOffset = Offset(details.localFocalPoint.dx,details.localFocalPoint.dy);
          newSize = Size(currentRect.width, currentRect.height);
          break;
        case "TopRight":
          customOffset = Offset(currentRect.left, details.localFocalPoint.dy);
          newSize = Size(details.localFocalPoint.dx - currentRect.left, currentRect.height);
          break;
        case "BottomLeft":
          customOffset = Offset(details.localFocalPoint.dx, currentRect.top);
          newSize = Size(currentRect.width, details.localFocalPoint.dy - currentRect.top);
          break;
        case "BottomRight":
          double newWidth = (currentRect.left + details.localFocalPoint.dx) - currentRect.left;
          double newHeight = (currentRect.top + details.localFocalPoint.dy) - currentRect.top;
          newSize = Size(newWidth,newHeight);
          customOffset = Offset(currentRect.left,currentRect.top);
          break;
        default:
          customOffset = details.localFocalPoint;
          break;
      }
      Log.i("当前方向：${state.customDirection},大小: ${newSize}，位置：${customOffset}");
      state.rectSize.value = newSize;
      state.customOffset.value = customOffset;
    }


    double scaleValue = details.scale;
    double value = 0;
    if(scaleValue >= state.maxScale){
      value = state.maxScale;
    }else if(scaleValue <= state.minScale){
      value = state.minScale;
    }else{
      value = scaleValue;
    }
    state.scale.value = value;
    // Log.i("当前缩放倍率：${value}");
  }


  onPanUpdate(DragUpdateDetails details){
    Log.i("当前移动的点位：${details?.localPosition}");
  }

  /*
   * @author Marinda
   * @date 2023/7/21 14:34
   * @description 显示边框裁剪
   */

  showCustomWidget(){
    state.showCustomWidget.value = !state.showCustomWidget.value;
    Log.i("显示边框裁剪");
  }


}
