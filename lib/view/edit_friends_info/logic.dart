import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/input_box.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/db/dao/friends_note_dao.dart';
import 'package:silentchat/db/db_manager.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/util/overlay_manager.dart';
import 'package:drift/drift.dart' as drift;
import 'state.dart';

class EditFriendsInfoLogic extends GetxController {
  final EditFriendsInfoState state = EditFriendsInfoState();
  final db = DBManager();
  final userLogic = Get.find<UserLogic>();
  final userState = Get.find<UserLogic>().state;

  @override
  void onInit() async{
    if(Get.arguments != null){
      //朋友id
      state.user.value = Get.arguments;
    }
    await initNickName();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    OverlayManager().removeOverlay("inputBox");
    // TODO: implement onClose
    super.onClose();

  }

  /*
   * @author Marinda
   * @date 2023/9/15 11:26
   * @description 初始化别名
   */
  initNickName() async{
    String nickName = "";
    var dao = FriendsNoteDao(db);
    int uid = state.user.value.id ?? -1;
    FriendsNoteData? data = await dao.selectByUid(uid);
    if(data != null){
      nickName = data!.nickname;
    }else{
      nickName = state.user.value.username ?? "";
    }
    state.nickName = nickName;
  }

  /*
   * @author Marinda
   * @date 2023/9/15 11:32
   * @description 显示修改备注
   */
  showUpdateNote() async{
    await initNickName();
    OverlayManager().createOverlay("inputBox",InputBoxComponent("更改备注",state.nickName,updateFriendsNote));
  }

  /*
   * @author Marinda
   * @date 2023/9/15 10:19
   * @description 更改备注
   */
  updateFriendsNote(TextEditingController controller) async{
    String text = controller.text;
    FriendsNoteDao dao = FriendsNoteDao(db);
    int uid = state.user.value.id ?? -1;
    FriendsNoteData? data = await dao.selectByUid(uid);
    if(data == null){
      FriendsNoteData friendsNoteData = await dao.insertNote(FriendsNoteCompanion(
        uid: drift.Value(state.user.value.id ?? -1),
        username: drift.Value(state.user.value.username ?? ""),
        nickname: drift.Value(state.nickName)
      ));
      Log.i("插入朋友备注信息: ${friendsNoteData.id}");
    }else{
      Map<String,dynamic> map = data.toJson();
      map["nickname"] = text;
      FriendsNoteData noteData = FriendsNoteData.fromJson(map);
      var result = await dao.updateNote(noteData);
      Log.i("修改结果: ${result}");
    }
    userState.notesMap[uid] = text;
    Log.i("当前备注文本为：${text}");
    OverlayManager().removeOverlay("inputBox");
  }

  /*
   * @author Marinda
   * @date 2023/9/15 14:40
   * @description 删除好友
   */
  removeFriend() async{

  }
}
