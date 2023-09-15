import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/input_box.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/util/overlay_manager.dart';

import 'state.dart';

class EditFriendsInfoLogic extends GetxController {
  final EditFriendsInfoState state = EditFriendsInfoState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  showUpdateNote(){
    OverlayManager().createOverlay("inputBox",InputBoxComponent("更改备注", updateFriendsNote));
  }

  /*
   * @author Marinda
   * @date 2023/9/15 10:19
   * @description 更改备注
   */
  updateFriendsNote(TextEditingController controller){
    String text = controller.text;
    Log.i("当前备注文本为：${text}");
  }
}
