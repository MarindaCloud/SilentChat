import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'logic.dart';

class SpacePage extends StatelessWidget {
  SpacePage({Key? key}) : super(key: key);

  final logic = Get.find<SpaceLogic>();
  final state = Get
      .find<SpaceLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          body: Stack(
            children: [
              //顶部
              Positioned(
                top: 0.rpx,
                left: 0,
                child: Container(
                  width: Get.width,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(239, 241, 253, 1)),
                    child: SafeArea(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform.translate(
                              offset: Offset(30, 0),
                              child: Container(
                                  child: IconButtonComponent(
                                      "back", Colors.grey.withOpacity(.7))),
                            ),
                            Center(
                                child: Container(
                                    child: Text(
                                      "好友动态",
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
              //
              Container(
                margin: EdgeInsets.only(top: 450.rpx),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(239, 241, 253, 1)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //头像信息
                      Container(
                        margin: EdgeInsets.only(
                            left: 50.rpx, top: 300.rpx, bottom: 100.rpx),
                        child: Row(
                          children: [
                            //头像
                            Container(
                              width: 300.rpx,
                              height: 300.rpx,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10000),
                                  image: DecorationImage(
                                      image: Image
                                          .network(
                                          "${logic.userState.user.value.portrait}")
                                          .image,
                                      fit: BoxFit.cover)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 100.rpx,
                            right: 180.rpx,
                            top: 80.rpx,
                            bottom: 50.rpx),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromRGBO(235, 235, 235, 1)))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //相册
                            InkWell(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 30.rpx),
                                      child: SizedBox(
                                        width: 120.rpx,
                                        height: 120.rpx,
                                        child: Image.asset(
                                          "assets/icon/tuxiang.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "相册",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                print("相册");
                              },
                            ),
                            //说说
                            InkWell(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 30.rpx),
                                      child: SizedBox(
                                        width: 130.rpx,
                                        height: 130.rpx,
                                        child: Image.asset(
                                          "assets/icon/xiaoxiqipao.png",
                                          fit: BoxFit.fill,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "说说",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                print("说说");
                              },
                            ),
                            //相册
                            InkWell(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 30.rpx),
                                      child: SizedBox(
                                        width: 130.rpx,
                                        height: 130.rpx,
                                        child: Image.asset(
                                          "assets/icon/pifu.png",
                                          fit: BoxFit.fill,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "个性化",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                print("个性化");
                              },
                            ),
                            //相册
                            InkWell(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 30.rpx),
                                      child: SizedBox(
                                        width: 130.rpx,
                                        height: 130.rpx,
                                        child: Image.asset(
                                          "assets/icon/tuxiang.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "相册",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                print("相册");
                              },
                            ),
                            //相册
                            InkWell(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 30.rpx),
                                      child: SizedBox(
                                        width: 130.rpx,
                                        height: 130.rpx,
                                        child: Image.asset(
                                          "assets/icon/tuxiang.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "相册",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                print("相册");
                              },
                            )
                          ],
                        ),
                      ),
                      //内容
                      Container(
                        margin: EdgeInsets.only(top: 80.rpx),
                        // color: Colors.white,
                        child: state.dynamicViewInfoList.isEmpty ? Container(color: Colors.white,height: Get.height.rpx ,child: Center(child: Text("暂无好友动态",style: TextStyle(color: Colors.black,fontSize: 16),))) :SingleChildScrollView(
                          child: Column(
                            children: logic.buildSpaceDynamicList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //相关导航
              //内容
            ],
          ));
    });
  }
}