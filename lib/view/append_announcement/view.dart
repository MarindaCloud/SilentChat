import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/common/expansion/image_path.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'logic.dart';

class AppendAnnouncementPage extends StatelessWidget {
  AppendAnnouncementPage({Key? key}) : super(key: key);

  final logic = Get.find<AppendAnnouncementLogic>();
  final state = Get
      .find<AppendAnnouncementLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Container(
          color: Colors.white,
          child: SafeArea(
            // bottom: false,
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
                              Get.back(result: state.viewAnnouncement.value);
                            },)
                      ),
                      Container(
                        child: Text(
                          "发布新公告",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox()
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border(top: BorderSide(
                                color: Color.fromRGBO(245, 245, 245, 1),
                                width: 1
                            ))
                        ),
                        margin: EdgeInsets.only(top: 80.rpx, bottom: 30.rpx),
                        padding: EdgeInsets.only(left: 30.rpx, right: 30.rpx),
                        child: TextField(
                          controller: state.contentController,
                          maxLines: null,
                          maxLength: null,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16
                          ),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 50.rpx, right: 50.rpx),
                            hintText: "请输入你的公告信息",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16
                            ),
                          ),
                        )
                    )
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 50.rpx, left: 70.rpx),
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    child: state.imgPath.value != "" ? SizedBox(
                      width: 600.rpx,
                      height: 600.rpx,
                      child: Stack(
                        children: [
                          SizedBox.expand(
                            child: Image.file(File(state.imgPath.value), fit: BoxFit
                              .fill)),
                          Positioned(
                              right: 0.rpx,
                              top: 0.rpx,
                              child: InkWell(
                                child: SizedBox(
                                  width: 100.rpx,
                                  height: 100.rpx,
                                  child: Image.asset(
                                    "shanchu2.png".icon, fit: BoxFit.fill,color: Colors.white,),
                                ),
                                onTap: ()=>logic.clearImage(),
                              )
                          ),
                        ],
                      ),
                    ) : SizedBox(
                      width: 150.rpx,
                      height: 150.rpx,
                      child: Image.asset("tuxiang.png".icon, fit: BoxFit.fill),
                    ),
                    onTap: () => logic.pickImage(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: 30.rpx, left: 70.rpx, right: 70.rpx),
                  padding: EdgeInsets.only(top: 100.rpx),
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Color.fromRGBO(
                          245, 245, 245, 1), width: 1))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            InkWell(
                              child: Container(
                                width: 400.rpx,
                                height: 150.rpx,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                  child: Text(
                                    "取消",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                print("取消！");
                              },
                            ),
                            SizedBox(width: 100.rpx),
                            InkWell(
                              child: Container(
                                width: 400.rpx,
                                height: 150.rpx,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 153, 255, 1),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                  child: Text(
                                    "发布",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                print("发布！");
                                logic.submit();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

        ),
      );
    });
  }
}
