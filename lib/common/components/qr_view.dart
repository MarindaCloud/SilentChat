import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:qr_flutter/qr_flutter.dart';
class QrViewComponent extends StatelessWidget{

  final dynamic data;
  final Function closeFunction;
  QrViewComponent(this.data,this.closeFunction);


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: Get.width,
        height: 500.rpx,
        color: Colors.white.withOpacity(.3),
        child: Stack(
          children: [
            SizedBox.expand(
              child: InkWell(
                onTap: (){
                  this.closeFunction();
                },
              ),
            ),
            Center(
              child: QrImageView(
                data: data,
                size: 320,
                embeddedImage: Image.asset("assets/user/portait.png").image,
                gapless: false,
                errorStateBuilder: (ctx,err){
                  return Center(
                    child: Text("无法校验的QR码",textAlign: TextAlign.center,style: TextStyle(color: Colors.red)),
                  );
                },
              ),
            ),
            Positioned(
              bottom: Get.height / 3.5,
                width: Get.width,
                child: Center(child: Text("扫描上方二维码加我默讯",style: TextStyle(color: Colors.red,fontSize: 20),)),
            )
          ],
        ),
      ),
    );
  }

}