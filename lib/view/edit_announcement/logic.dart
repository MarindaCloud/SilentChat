import 'dart:io';

import 'package:get/get.dart';
import 'package:silentchat/entity/announcement_view.dart';
import 'package:silentchat/entity/group_announcement.dart';
import 'package:silentchat/network/api/common_api.dart';
import 'package:silentchat/view/group_announcement/logic.dart';
import 'package:silentchat/view/group_announcement/state.dart';
import 'package:image_picker/image_picker.dart';
import 'state.dart';
import 'package:bot_toast/bot_toast.dart';
/**
 * @author Marinda
 * @date 2023/11/16 14:49
 * @description 编辑公告页
 */
class EditAnnouncementLogic extends GetxController {
  final EditAnnouncementState state = EditAnnouncementState();
  final GroupAnnouncementLogic announcementLogic = Get.find<GroupAnnouncementLogic>();
  final GroupAnnouncementState announcementState = Get.find<GroupAnnouncementLogic>().state;

  @override
  void onInit() {
    var args = Get.arguments;
    state.announcementView = args["element"];
    state.textController.text = state.announcementView.groupAnnouncement?.content ?? "";
    state.imgSrc.value = state.announcementView.groupAnnouncement?.image ?? "";
    super.onInit();
  }

  pickImage() async{
    XFile? imgElement = await state.imagePicker.pickImage(source: ImageSource.gallery);
    print('图像地址: ${imgElement!.path}');
    state.imgSrc.value = imgElement.path;
  }

  /*
   * @author Marinda
   * @date 2023/11/16 15:17
   * @description 修改公告
   */
  updateAnnouncement() async{
    var groupAnnouncement = state.announcementView.groupAnnouncement ?? GroupAnnouncement();
    String text = state.textController.text;
    String src = state.imgSrc.value;
    if(src != "" && !src.startsWith("http")){
      src = await CommonAPI.uploadFile(File(src), "announcement");
    }
    await announcementLogic.updateAnnouncement(groupAnnouncement, 2,text: text,imageSrc: src,isTop: false);
    groupAnnouncement.image = src;
    groupAnnouncement.content = text;
    AnnouncementView newView = AnnouncementView(userName: state.announcementView.userName,groupAnnouncement: groupAnnouncement);
    state.announcementView = newView;
  }

  clearImage(){
    state.imgSrc.value = "";
  }

}
