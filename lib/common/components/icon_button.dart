import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/font_rpx.dart';
/*
 * @author Marinda
 * @date 2023/6/21 14:29
 * @description icon按钮组件
 */
class IconButtonComponent extends StatefulWidget{
  double width = 100;
  double height = 100;
  String iconName =  "";
  Color? color;
  Function onClick = (){Get.back();};
  IconButtonComponent.build(this.iconName,{Function? onClick}){
    if(onClick != null){
      this.onClick = onClick;
    }
  }

  IconButtonComponent(this.iconName,this.color);

  @override
  State<StatefulWidget> createState() {
    return IconButtonState();
  }

}

class IconButtonState extends State<IconButtonComponent>{

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        width: widget.width.rpx,
        height: widget.height.rpx,
        child: Image.asset("assets/icon/${widget.iconName}.png",fit: BoxFit.fill,color: widget.color,),
      ),
      onTap: (){
        widget.onClick();
      },
    );
  }

}