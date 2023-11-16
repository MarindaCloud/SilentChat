import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/expansion/image_path.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/announcement_view.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/group_announcement.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/group_announcement_api.dart';
import 'package:silentchat/network/api/group_api.dart';
import 'package:silentchat/util/date_time_util.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:silentchat/view/append_announcement/binding.dart';
import 'state.dart';

class GroupAnnouncementLogic extends GetxController {
  final GroupAnnouncementState state = GroupAnnouncementState();
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;
  @override
  void onInit() {
    init();
    // TODO: implement onInit
    super.onInit();
  }

  init() async{
    Map<String,dynamic> args = Get.arguments;
    state.group = args["group"];
    List<GroupAnnouncement> list = args["list"];
    List<AnnouncementView> viewList = [];
    Map<int,bool> openMap = {};
    for(var element in list){
      int ownerId = element.owner ?? 0;
      User user = await userLogic.selectByUid(ownerId);
      String userName = user.username ?? "";
      AnnouncementView announcementView = AnnouncementView(userName: userName,groupAnnouncement: element);
      int id = element.id ?? -1;
      openMap[id] = false;
      viewList.add(announcementView);
    }
    state.announcementOpenMap.value = openMap;
    state.announcementViewList.value = viewList;
    //页面渲染完毕之后进行排序
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state.announcementViewList.sort((a,b){
        int aIsTop = a.groupAnnouncement!.isTop ?? 0;
        int bIsTop = b.groupAnnouncement!.isTop ?? 0;
        return bIsTop.compareTo(aIsTop);
      });
      state.announcementViewList.refresh();
    });
  }

  /*
   * @author Marinda
   * @date 2023/11/15 16:40
   * @description 修改置顶公告
   */
  updateAnnouncement(GroupAnnouncement announcement,int type,{String? text,String? imageSrc,bool? isTop}) async{
      GroupAnnouncement updateElement = GroupAnnouncement.fromJson(announcement.toJson());
      switch(type){
        //type == 1 视为置顶
        case 1:
          updateElement.isTop = isTop == true ? 1 : 2;
          break;
        case 2:
          updateElement.isTop = isTop == true ? 1 : 2;
          updateElement.content = text;
          updateElement.image = imageSrc;
          break;
      }
      int announcementId = announcement.id ?? 0;
      //设置其他显示为0
      int index = findViewIndexByAnnouncement(announcementId);
      List<AnnouncementView> viewList = [];
      //过滤筛选
      for(var i = 0;i< state.announcementViewList.value.length;i++){
        var element = state.announcementViewList[i];
        GroupAnnouncement announcement = element.groupAnnouncement ?? GroupAnnouncement();
        if(i == index){
          announcement.isTop = 1;
        }else{
          announcement.isTop = 0;
          GroupAnnouncementAPI.update(announcement);
        }
        AnnouncementView view = AnnouncementView(userName: element.userName,groupAnnouncement: announcement);
        viewList.add(view);
      }
      //互换位置
      dynamic temp = state.announcementViewList[index];
      state.announcementViewList.removeAt(index);
      state.announcementViewList.insert(0, temp);
      var result = await GroupAnnouncementAPI.update(updateElement);
      if(result == 1){
        BotToast.showText(text: "修改成功！");
      }else{
        BotToast.showText(text: "修改失败");
      }
      state.announcementViewList.refresh();
  }

  /*
   * @author Marinda
   * @date 2023/11/16 11:09
   * @description 查找视图索引
   */
  findViewIndexByAnnouncement(int id){
    int index = 0;
    for(int i = 0;i<state.announcementViewList.length;i++){
      AnnouncementView view = state.announcementViewList[i];
      int announcementId = view.groupAnnouncement?.id ?? 0;
      if(announcementId == id){
        index = i;
      }
    }
    return index;
  }

  /*
   * @author Marinda
   * @date 2023/10/10 10:52
   * @description 跳转至添加公告
   */
  toAppendAnnouncement() async{
    var announcement = await Get.toNamed(AppPage.appendAnnouncement,arguments: state.group);
    if(announcement != null){
      state.announcementViewList.add(announcement);
      state.announcementViewList.refresh();
    }
  }

  /*
   * @author Marinda
   * @date 2023/10/9 17:58
   * @description 构建公告
   */
  buildGroupAnnouncement() {
    List<Widget> childrenList = [];
    var list = state.announcementViewList;
    for (AnnouncementView view in list) {
      GroupAnnouncement announcement = view.groupAnnouncement ?? GroupAnnouncement();
      Widget widget = Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 70.rpx,left: 100.rpx,right: 100.rpx,bottom: 70.rpx),
        margin: EdgeInsets.only(bottom: 80.rpx),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //基础信息
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "${view.userName}",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.rpx,right: 20.rpx),
                          child: Text(
                            "${DateTimeUtil.formatDateTime(DateTime.parse(announcement.time!), format: DateTimeUtil.ymdhn)}",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14
                            ),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            width: 160.rpx,
                            height: 90.rpx,
                            // padding: EdgeInsets.only(top: 5.rpx,bottom: 5.rpx,left: 15.rpx,right: 15.rpx),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: announcement.isTop == 1 ? Colors.red : Color.fromRGBO(203,235,255,1),
                            ),
                            child: Center(
                              child: Text(
                                "置顶",
                                style: TextStyle(
                                  color: announcement.isTop == 1 ? Colors.white : Color.fromRGBO(8,155,255,1),
                                  fontSize: 12,
                                  letterSpacing:0
                                ),
                              ),
                            ),
                          ),
                          onTap: (){
                            if(announcement.isTop == 1) return;
                            updateAnnouncement(announcement, 1,isTop: true);
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.rpx),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "${announcement.content}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              overflow: state.announcementOpenMap[announcement.id] == true ? TextOverflow.visible : TextOverflow.ellipsis
                            ),
                          ),
                        ),
                        SizedBox(width: 100.rpx,),
                        Container(
                          width: 500.rpx,
                          height: 300.rpx,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: Image.asset("assets/user/portait.png").image,
                              fit: BoxFit.fill
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                  if(announcement.content!.length! >= 25)
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 50.rpx),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              "展开",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15.rpx),
                            child: Transform.rotate(
                              angle: state.announcementOpenMap[announcement.id] ? 0 : pi / 2,
                              child: SizedBox(
                                width: 70.rpx,
                                height: 70.rpx,
                                child: Image.asset("zhankai.png".icon,fit: BoxFit.fill,color: Colors.blue,),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      state.announcementOpenMap[announcement.id] = !state.announcementOpenMap[announcement.id];
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      );
      childrenList.add(widget);
    }
    return childrenList;
  }
}
