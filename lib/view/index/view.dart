import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/view/index/widget/bottom_nav.dart';

import 'logic.dart';

class IndexPage extends StatelessWidget {

  IndexPage({Key? key}) : super(key: key);
  final logic = Get.find<IndexLogic>();
  final state = Get.find<IndexLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
          //  头部
            Expanded(child: state.contentWidget),
            // Expanded(child: SizedBox()),
            BottomNavWidget(1, (){})
          ],
        ),
      ),
    );
  }
}
