import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/back_button.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';

import 'logic.dart';

class VerifyPage extends StatelessWidget {
  VerifyPage({Key? key}) : super(key: key);

  final logic = Get.find<VerifyLogic>();
  final state = Get.find<VerifyLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Container(
          color: Color.fromRGBO(84, 176, 247, 1),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //  头部
                  Container(
                    height: 120.rpx,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.rpx,
                          height: 100.rpx,
                          child: BackButtonComponent.build(
                            100.rpx,
                            100.rpx,
                            color: Colors.white,
                            onClick: () {
                              Log.i("返回");
                              Get.back();
                            },
                          ),
                        ),
                        Container(
                          child: Text("验证消息",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                        Container()
                      ],
                    ),
                  ),
                  // SizedBox(height: 30),
                  //详细验证消息
                  Container(
                    // height: 1000,
                    margin: EdgeInsets.only(top: 20),
                    color: Color.fromRGBO(247, 247, 247, 1),
                    child: Column(
                      children: logic.buildFriendsVerifyList()
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
