import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/input_box.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/db/dao/friends_note_dao.dart';
import 'package:silentchat/db/dao/record_message_dao.dart';
import 'package:silentchat/db/db_manager.dart';
import 'package:silentchat/db/table/friends_note.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/chat_info.dart';
import 'package:silentchat/entity/friend.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/network/api/friends_api.dart';
import 'package:silentchat/network/api/message_api.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/util/overlay_manager.dart';
import 'package:drift/drift.dart' as drift;
import 'package:silentchat/view/contact/logic.dart';
import 'package:silentchat/view/message/logic.dart';
import 'package:bot_toast/bot_toast.dart';
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
   * 一共要涉及到三张表
   * 删除当前登录用户和这名用户的所有聊天详情 & 删除朋友关系 & 删除相关消息
   * 删除聊天详情 和 消息时异步删除操作，其余全部同步，更改视图和相关逻辑即可！
   */
  removeFriend() async{
    final db = DBManager();
    //删除聊天详情
    int uid = userState.uid.value;
    int receiverId = state.user.value.id ?? -1;
    //删除聊天消息
    List messageList = await MessageAPI.selectUserMessageList(uid, receiverId);
    if(messageList.isNotEmpty){
      for(Message message in messageList){
        int mid = message.id ?? -1;
        MessageAPI.removeMessage(mid);
      }
    }


    List<ChatInfo> chatInfoList = await MessageAPI.selectChatInfoByInUser(uid, receiverId);
    for(ChatInfo element in chatInfoList){
      int id = element.id ?? -1;
      //删除聊天详情
      MessageAPI.removeChatInfo(id);
    }
    //删除聊天记录缓存
    RecordMessageDao messageDao = RecordMessageDao(db);
    RecordMessageData? cacheMessageData = await messageDao.selectReceiverRecordMessageList(receiverId);
    if(cacheMessageData != null){
      //删除目标记录缓存
      await messageDao.deleteRecordMessageById(cacheMessageData.id);
    }

    //删除好友关系 & 备注
    List<Friend> friendsList = await FriendsAPI.selectByUid();
    Friend friend = friendsList.firstWhere((element) => element.fid == receiverId);
    int fid = friend.id ?? -1;
    await FriendsAPI.removeById(fid);
    //获取缓存中
    int friendIndex = userState.friendUserList.indexWhere((element) => element.id == receiverId);
    userState.friendUserList.removeAt(friendIndex);

    //删除好友备注
    FriendsNoteDao friendsNoteDao = FriendsNoteDao(db);
    FriendsNoteData? friendNoteData = await friendsNoteDao.selectByUid(receiverId);
    if(friendNoteData != null){
      await friendsNoteDao.deleteNote(friendNoteData.id);
    }


    //更新主页视图
    var messageLogic = Get.find<MessageLogic>();
    messageLogic.state.messageViewMap[state.user.value] = Message();
    var contactLogic = Get.find<ContactLogic>();
    contactLogic.initFriendsInfo();

    Get.offNamed(AppPage.index);
    BotToast.showText(text: "删除好友完毕！");
    Log.i("删除好友完毕！");
  }
}
