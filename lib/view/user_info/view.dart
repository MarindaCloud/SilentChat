import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/view/user_info/widget/footer_component.dart';
import 'package:silentchat/view/user_info/widget/header_nav.dart';
import 'package:silentchat/view/user_info/widget/main_component.dart';
import 'package:silentchat/view/user_info/widget/update_portrait.dart';
import 'logic.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoPage({Key? key}) : super(key: key);

  final logic = Get.find<UserInfoLogic>();
  final state = Get
      .find<UserInfoLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Stack(
          children: [
            //背景图
            Container(
              child: Column(
                children: [
                  //头部
                  Container(
                    height: 200,
                    width: Get.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image
                                .network(state.user.value.portrait ?? "")
                                .image,
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                  MainComponent(logic, state),
                ],
              ),
            ),
            Visibility(
                visible: state.updatePortrait.value,
                child: UpdatePortraitComponent(logic,state)),
            //头部
            Positioned(
                top: 50.rpx,
                left: 0.rpx,
                child: HeaderNavComponent(state.user.value.id ?? -1)
            ),
            Positioned(
              bottom: 0.rpx,
              left: 0.rpx,
              child: FooterComponent(logic, state),
            )

          ],
        ),
      );
    });
  }
}
