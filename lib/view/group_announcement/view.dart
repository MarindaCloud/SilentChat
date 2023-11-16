import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/back_button.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'logic.dart';

class GroupAnnouncementPage extends StatelessWidget {
  GroupAnnouncementPage({Key? key}) : super(key: key);

  final logic = Get.find<GroupAnnouncementLogic>();
  final state = Get
      .find<GroupAnnouncementLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Container(
          color: Color.fromRGBO(242, 242, 242, 1),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                //header
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.translate(
                          offset: Offset(130.rpx, 0),
                          child: IconButtonComponent.build("back",
                            color: Colors.black, onClick: () {
                              Get.back();
                            },)
                      ),
                      Container(
                        child: Text(
                          "群公告",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox()
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 100.rpx,right: 100.rpx,top: 100.rpx),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                          child: Text(
                            "${state.group.name}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              letterSpacing: 0
                            ),
                          ),
                        ),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0,153,255,1),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          width: 500.rpx,
                          height: 150.rpx,
                          child: Center(
                            child: Text(
                              "发布新公告",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16
                              ),
                            ),
                          ),
                        ),
                        onTap: (){
                          logic.toAppendAnnouncement();
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 100.rpx,right: 100.rpx,top: 100.rpx),
                      child: state.announcementViewList.isEmpty ? Center(child: Text("暂无群公告",style: TextStyle(color: Colors.grey,fontSize: 20))) : SingleChildScrollView(
                        child: Column(
                          children: logic.buildGroupAnnouncement(),
                        ),
                      ),
                    )
                )
              ],
            ),
          ),

        ),
      );
    });
  }
}
