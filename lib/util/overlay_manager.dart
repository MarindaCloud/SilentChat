import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:silentchat/main.dart';


class OverlayManager extends GetxService {
  //外部调用
  static OverlayManager? overlayManager;

  OverlayManager._();
  Map<String, OverlayEntry> floatOverlay = {};
  static Map<String, String> uniqueKeyMap = {};
  //存放所有的overlay
  Map<String, OverlayEntry> overlayMap = {};

  //保存所有的overlay的的状态 true:显示 false:隐藏
  final overlayStatus = <String, bool>{}.obs;

  factory OverlayManager() {
    // 只能有一个实例
    overlayManager ??= OverlayManager._();
    return overlayManager!;
  }

  //移除指定的overlay
  void removeOverlay(String key) {
    //一键清楚所有的overlay，用于退出登录的时候
    if (key == 'all') {
      overlayMap.forEach((key,value){
      print('存在的悬浮控件: ${key}');
      });
      overlayMap.forEach((key, value) => value.remove());
      overlayMap.clear();
      floatOverlay.clear();
      overlayStatus.clear();
    } else if (overlayMap.containsKey(key)) {
      overlayMap[key]!.remove();
      overlayMap.remove(key);
      floatOverlay.remove(key);
      overlayStatus.remove(key);

    }
  }

  void hideOverlay(String key) {
    if (overlayMap.containsKey(key)) {
      overlayStatus[key] = false;
    }
  }

  void showOverlay(String key) {
    if (overlayMap.containsKey(key)) {
      overlayStatus[key] = true;
    }
  }

  bool containsOverlay(String key){
    return overlayMap.containsKey(key);
  }

  //添加overlay
  void createOverlay(String key, var widget,
      {String above = '', String below = '',bool uniqueKey = false, isFloatWidget = false}) {
    //添加前先判断是否存在，如果存在则先移除
    removeOverlay(key);

    OverlayEntry? aboveEntry = overlayMap[above];
    OverlayEntry? belowEntry = overlayMap[below] ??
        (floatOverlay.isNotEmpty ? floatOverlay.values.first : null);

    overlayStatus[key] = true;
    if (uniqueKey) {
      uniqueKeyMap[key] = '$key-${DateTime.now().microsecondsSinceEpoch}';
    }
    var widgetValue = widget is Function ? widget.call() : widget;
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) =>  isFloatWidget ? widgetValue : OverlayItem(widgetValue, key));
    if(isFloatWidget) floatOverlay[key] = overlayEntry;
    overlayMap[key] = overlayEntry;
    MainApp.navigatorKey.currentState!.overlay!.insert(
        overlayEntry, above: aboveEntry, below: belowEntry);
  }
}

// ignore: must_be_immutable
class OverlayItem extends StatelessWidget {
  OverlayManager overlayManager = Get.find<OverlayManager>();
  Widget child;
  String name;
  OverlayItem(this.child, this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Offstage(offstage: !overlayManager.overlayStatus[name]!,
          child: child);
    });
  }
}

