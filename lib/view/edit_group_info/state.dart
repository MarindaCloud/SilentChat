import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/group.dart';
class EditGroupInfoState {
  final group = Group().obs;
  final size = Size.zero.obs;
  EditGroupInfoState() {
    ///Initialize variables
  }
}
