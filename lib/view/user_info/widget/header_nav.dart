import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/back_button.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/util/font_rpx.dart';
/**
 * @author Marinda
 * @date 2023/6/21 14:22
 * @description 头部导航
 */
class HeaderNavComponent extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return HeaderNavComponentState();
  }

}

class HeaderNavComponentState extends State<HeaderNavComponent>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: Get.width,
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10.rpx),
        child: Row(
          children: [
            IconButtonComponent("back", Colors.white),
            Expanded(child: SizedBox()),
            IconButtonComponent("qr",Colors.white)
          ],
        ),
      ),
    );
  }

}