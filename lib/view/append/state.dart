import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AppendState {
  TextEditingController? accountTextController = TextEditingController(text: "");
  final searchResultList = [].obs;
  //用来区分群聊或者联系人 1 联系人 2群聊
  int type = 1;
  //搜索结果
  final searchFlag = false.obs;
  AnimationController? animationController;
  Animation<Offset>? animation;
  AppendState() {
    ///Initialize variables
  }
}
