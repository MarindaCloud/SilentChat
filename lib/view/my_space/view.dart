import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/common/expansion/image_path.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'logic.dart';

class MySpacePage extends StatelessWidget {
  MySpacePage({Key? key}) : super(key: key);

  final logic = Get.find<MySpaceLogic>();
  final state = Get.find<MySpaceLogic>().state;

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
                              offset: Offset(20, 0),
                              child: Container(
                                  child: IconButtonComponent(
                                      "back", Colors.grey.withOpacity(.7))),
                            ),
                            Center(
                                child: Container(
                                    child: Text(
                                      "空间",
                                      style: TextStyle(fontSize: 17),
                                    ))),
                            Transform.translate(
                              offset: Offset(-20,0),
                              child: InkWell(
                                child: SizedBox(
                                  width: 100.rpx,
                                  height: 100.rpx,
                                  child: Image.asset(
                                      "bianji.png".icon,
                                      fit: BoxFit.fill,
                                  ),
                                ),
                                onTap: ()=>logic.toReleaseDynamicPage(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
                      //空间信息
                      Container(
                        padding: EdgeInsets.only(
                            top: 80.rpx,
                            bottom: 50.rpx),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromRGBO(235, 235, 235, 1)))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 50.rpx ),
                              padding: EdgeInsets.only(bottom: 50.rpx),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(235, 235, 235, 1),
                                    width: 1
                                  )
                                )
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 50.rpx),
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "空间等级：",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14
                                            )
                                          ),
                                          TextSpan(
                                            text: "1级",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14
                                            )
                                          )
                                        ]
                                      )
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 50.rpx),
                                    child: Text.rich(
                                        TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: "当前进度：",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14
                                                  )
                                              ),
                                              TextSpan(
                                                  text: "小试牛刀",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 14
                                                  )
                                              )
                                            ]
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //空间动态详情
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
            ],
          ));
    });
  }
}
