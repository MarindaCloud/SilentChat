import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/common/expansion/image_path.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'logic.dart';

/**
 * @author Marinda
 * @date 2023/11/16 14:49
 * @description 编辑公告页
 */
class EditAnnouncementPage extends StatelessWidget {
  EditAnnouncementPage({Key? key}) : super(key: key);

  final logic = Get.find<EditAnnouncementLogic>();
  final state = Get
      .find<EditAnnouncementLogic>()
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
                              Get.back(result: state.announcementView);
                            },)
                      ),
                      Container(
                        child: Text(
                          "修改公告",
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
                          controller: state.textController,
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
                    child: state.imgSrc.value != "" ? SizedBox(
                      width: 600.rpx,
                      height: 600.rpx,
                      child: Stack(
                        children: [
                          SizedBox.expand(
                              child: state.imgSrc.value.startsWith("http") ? Image
                                  .network(state.imgSrc.value, fit: BoxFit
                                  .fill) : Image.file(
                                  File(state.imgSrc.value), fit: BoxFit
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
                                    "修改",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () => logic.updateAnnouncement(),
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
