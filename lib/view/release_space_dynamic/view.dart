import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/common/expansion/image_path.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'logic.dart';

/**
 * @author Marinda
 * @date 2023/11/21 15:29
 * @description 发布空间动态页
 */
class ReleaseSpaceDynamicPage extends StatelessWidget {
  ReleaseSpaceDynamicPage({Key? key}) : super(key: key);

  final logic = Get.find<ReleaseSpaceDynamicLogic>();
  final state = Get
      .find<ReleaseSpaceDynamicLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Container(
          color: Color.fromRGBO(239, 241, 253, 1),
          child: Stack(
            children: [
              //顶部
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: Get.width,
                  child: Container(
                    child: SafeArea(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform.translate(
                              offset: Offset(20, 0),
                              child: Container(
                                  child: IconButtonComponent.build(
                                      "back",color: Colors.grey.withOpacity(.7),onClick: logic.back,)),
                            ),
                            Center(
                                child: Container(
                                    child: Text(
                                      "发布动态",
                                      style: TextStyle(fontSize: 17),
                                    ))),
                            SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //内容
              Container(
                margin: EdgeInsets.only(
                    top: 400.rpx, left: 100.rpx, right: 100.rpx),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: Get.height / 2,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Container(
                            child: SizedBox(
                              child: TextField(
                                controller: state.contentController,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1
                                        ),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    contentPadding: EdgeInsets.only(left: 50.rpx,right: 50.rpx),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1
                                        ),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    hintText: "请输入内容",
                                    hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16
                                    )
                                ),
                                maxLines: null,
                                maxLength: null,
                              ),
                            ),
                          ),
                          //图像选择
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 50.rpx, left: 50.rpx,top: 0.rpx),
                              child: Wrap(
                                children:  state.imgPath.isNotEmpty ? logic.buildPickImageList() : [
                                  InkWell(
                                    child: SizedBox(
                                      width: 150.rpx,
                                      height: 150.rpx,
                                      child: Image.asset(
                                          "tuxiang.png".icon, fit: BoxFit.fill),
                                    ),
                                    onTap: () => logic.pickImage(),
                                  ),
                                ]
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 100.rpx),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Container(
                                width: 200.rpx,
                                height: 150.rpx,
                                color: Colors.grey,
                                child: Center(
                                  child: Text(
                                    "清空",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14
                                    ),
                                  ),
                                ),
                              ),
                              onTap: ()=>logic.resetContent(),
                            ),
                          ),
                          SizedBox(width: 200.rpx),
                          Expanded(
                            child: InkWell(
                              child: Container(
                                width: 200.rpx,
                                height: 150.rpx,
                                color: Colors.blue,
                                child: Center(
                                  child: Text(
                                    "发布",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14
                                    ),
                                  ),
                                ),
                              ),
                              onTap: ()=>logic.submit(),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
