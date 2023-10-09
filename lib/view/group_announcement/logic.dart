import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/group_announcement.dart';
import 'package:silentchat/util/date_time_util.dart';
import 'package:silentchat/util/font_rpx.dart';

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
                              color: Color.fromRGBO(203,235,255,1),
                            ),
                            child: Center(
                              child: Text(
                                "置顶",
                                style: TextStyle(
                                  color: Color.fromRGBO(8,155,255,1),
                                  fontSize: 12,
                                  letterSpacing:0
                                ),
                              ),
                            ),
                          ),
                          onTap: (){
                            print("置顶！");
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
                        Container(
                          child: Text(
                            "${announcement.content}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,

                            ),
                          ),
                        ),
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
                  Container(
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
                        )
                      ],
                    ),
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
