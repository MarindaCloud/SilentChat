import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/announcement_view.dart';
import 'package:silentchat/entity/group_announcement.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/common_api.dart';
import 'package:silentchat/network/api/group_announcement_api.dart';
import 'package:silentchat/util/log.dart';
import 'state.dart';
import 'package:bot_toast/bot_toast.dart';
class AppendAnnouncementLogic extends GetxController {
  final AppendAnnouncementState state = AppendAnnouncementState();
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;
  @override
  void onInit() {
    init();
    // TODO: implement onInit
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/10/10 10:54
   * @description 初始化公告信息
   */
  init(){
    var group = Get.arguments;
    state.group = group;
  }

  /*
   * @author Marinda
   * @date 2023/10/10 10:58
   * @description 提交
   */
  submit() async{
    String content = state.contentController.text;
    String imgSrc = state.imgPath.value;
    int gid = state.group.id ?? 0;
    int ownerId = userState.uid.value;
    if(imgSrc != ""){
      imgSrc = await CommonAPI.uploadFile(File(imgSrc), "announcement");
    }
    Log.i("当前图片地址：${imgSrc}");
    GroupAnnouncement announcement = GroupAnnouncement(gid:gid,content: content,time: DateTime.now().toString(),image: imgSrc,owner: ownerId,isTop: 0);
    User user = await userLogic.selectByUid(ownerId);
    AnnouncementView view = AnnouncementView(userName: user.username ?? "",groupAnnouncement: announcement);
    var resultId = await GroupAnnouncementAPI.insert(announcement);
    announcement.id = resultId;
    if(resultId >= 1){
      BotToast.showText(text: "发布成功！");
      state.viewAnnouncement.value = view;
    }else{
      BotToast.showText(text: "发布失败！");
    }
  }

  pickImage() async{
    XFile? imgElement = await state.imagePicker.pickImage(source: ImageSource.gallery);
    print('图像地址: ${imgElement!.path}');
    state.imgPath.value = imgElement.path;
  }

  clearImage(){
    state.imgPath.value = "";
  }
}
