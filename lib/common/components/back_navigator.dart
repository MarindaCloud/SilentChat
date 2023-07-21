import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/back_button.dart';
import 'package:silentchat/util/font_rpx.dart';
/**
 * @author Marinda
 * @date 2023/7/20 15:00
 * @description 返回的基础导航组件
 */
class BackNavigatorComponent extends StatelessWidget{
  final String title;
  Function? backFun;
  Color? fontColor;
  Color? backButtonColor;
  BackNavigatorComponent(this.title,[this.backFun,this.fontColor,this.backButtonColor]);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 200.rpx,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
              child: BackButtonComponent.build(100,100,color: backButtonColor ?? Colors.white,onClick: backFun ?? Get.back)
          ),
          Container(
            margin: EdgeInsets.only(right: 40),
              child: Text(title,style: TextStyle(color: fontColor ?? Colors.white,fontSize: 18))
          ),
          SizedBox()
        ],
      ),
    );
  }

}