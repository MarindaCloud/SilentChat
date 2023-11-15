import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/expansion/image_path.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/group_announcement.dart';
import 'package:silentchat/network/api/group_announcement_api.dart';
import 'package:silentchat/network/api/group_api.dart';
import 'package:silentchat/util/date_time_util.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:bot_toast/bot_toast.dart';
import 'state.dart';

class GroupAnnouncementLogic extends GetxController {
  final GroupAnnouncementState state = GroupAnnouncementState();

  @override
  void onInit() {
    init();
    // TODO: implement onInit
    super.onInit();
  }

  init(){
    Map<String,dynamic> args = Get.arguments;
    state.group = args["group"];
    state.groupAnnouncementList.value = args["list"];

    Map<int,bool> openMap = {};
    for(var element in state.groupAnnouncementList){
      int id = element.id ?? -1;
      openMap[id] = false;
    }
    state.announcementOpenMap.value = openMap;
    //页面渲染完毕之后进行排序
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state.groupAnnouncementList.sort((a,b){
        int aIsTop = a.isTop ?? 0;
        int bIsTop = b.isTop ?? 0;
        return bIsTop.compareTo(aIsTop);
      });
      state.groupAnnouncementList.refresh();
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
      //设置其他显示为0
      int index = state.groupAnnouncementList.indexOf(announcement);
      for(var i = 0;i<state.groupAnnouncementList.length;i++){
        if(i == index){
          continue;
        }
        state.groupAnnouncementList[i].isTop = 0;
      }
      //互换位置
      dynamic temp = state.groupAnnouncementList[index];
      state.groupAnnouncementList[0] = updateElement;
      state.groupAnnouncementList[index] = temp;
      for(var element in state.groupAnnouncementList.value){
        if(element.id == updateElement.id){
          continue;
        }
        GroupAnnouncementAPI.update(element);
      }
      var result = await GroupAnnouncementAPI.update(updateElement);
      if(result == 1){
        BotToast.showText(text: "修改成功！");
      }else{
        BotToast.showText(text: "修改失败");
      }
      //这里是排序逻辑，暂时未定
      // state.groupAnnouncementList.sort((a,b){
      //   DateTime aDt = DateTime.parse(a.time!);
      //   DateTime bDt = DateTime.parse(b.time!);
      //   return aDt.compareTo(bDt);
      // });
      state.groupAnnouncementList.refresh();
  }

  /*
   * @author Marinda
   * @date 2023/10/10 10:52
   * @description 跳转至添加公告
   */
  toAppendAnnouncement(){
    Get.toNamed(AppPage.appendAnnouncement,arguments: state.group);
  }

  /*
   * @author Marinda
   * @date 2023/10/9 17:58
   * @description 构建公告
   */
  buildGroupAnnouncement() {
    List<Widget> childrenList = [];
    var list = state.groupAnnouncementList;
    for (GroupAnnouncement announcement in list) {
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
                            "发起者",
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
