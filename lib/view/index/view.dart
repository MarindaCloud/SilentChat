import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/view/index/widget/bottom_nav.dart';
import 'package:silentchat/view/index/widget/user_info.dart';

import 'logic.dart';

class IndexPage extends StatelessWidget {

  IndexPage({Key? key}) : super(key: key);
  final logic = Get.find<IndexLogic>();
  final state = Get
      .find<IndexLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Container(
          child: Stack(
            children: [
              //main 内容
              Container(
                child: Column(
                  children: [
                    //  头部
                    GetBuilder<IndexLogic>(builder: (logic) {
                      return Expanded(child: state.contentWidget);
                    }),
                    BottomNavWidget(logic, state)
                  ],
                ),),
              //mask
              Visibility(
                visible: state.showUserInfo.value,
                child: Positioned(
                    left: Get.width / 2,
                    child: Container(
                      width: Get.width,
                      height: Get.height,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.3)
                      ),
                    )
                ),
              ),
              //用户信息
              Visibility(
                visible: state.showUserInfo.value,
                child: Positioned(
                    child: Container(
                      width: Get.width / 2,
                      height: Get.height,
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: UserInfoWidget(logic, state),
                    )
                ),
              )
              // Expanded(child: SizedBox()),

            ],
          ),
        ),
      );
    });
  }
}
