import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/font_rpx.dart';
/**
 * @author Marinda
 * @date 2023/5/26 10:29
 * @description  全局返回按钮组件
 */
class BackButtonComponent extends StatefulWidget{
  double width = 100;
  double height = 100;
  Function onClick = (){Get.back();};
  Color? color;
  BackButtonComponent.build(double width,double height,{Function? onClick,this.color}){
    this.width = width;
    this.height = height;
    if(onClick != null){
      this.onClick = onClick;
    }
  }

  BackButtonComponent({Function? onClick}){
    if(onClick != null){
      this.onClick = onClick;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return BackButtonState();
  }

}

class BackButtonState extends State<BackButtonComponent>{

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        width: widget.width.rpx,
        height: widget.height.rpx,
        child: widget.color == null ? Image.asset("assets/icon/back.png",fit: BoxFit.fill,) : Image.asset("assets/icon/back.png",fit: BoxFit.fill,color: widget.color,),
      ),
      onTap: (){
        widget.onClick();
      },
    );
  }

}