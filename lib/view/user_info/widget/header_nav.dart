import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/back_button.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/common/components/qr_view.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/util/overlay_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:silentchat/util/util.dart';
/**
 * @author Marinda
 * @date 2023/6/21 14:22
 * @description 头部导航
 */
class HeaderNavComponent extends StatefulWidget{

  final int uid;

  HeaderNavComponent(this.uid);


  @override
  State<StatefulWidget> createState() {
    return HeaderNavComponentState();
  }

}

class HeaderNavComponentState extends State<HeaderNavComponent>{


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: Get.width,
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10.rpx),
        child: Row(
          children: [
            IconButtonComponent("back", Colors.grey),
            Expanded(child: SizedBox()),
            IconButtonComponent.build("qr",onClick: showQrComponent,color: Colors.grey,)
          ],
        ),
      ),
    );
  }

  /*
   * @author Marinda
   * @date 2023/7/3 15:59
   * @description 显示组件信息
   */
  showQrComponent(){
    String encodeStr = GlobalUtil.encoder(widget.uid.toString(), "base64");
    Log.i("用户uid: ${widget.uid}");
    Log.i("加密后的用户数据: ${encodeStr}");
    OverlayManager().createOverlay("qrViewComponent", QrViewComponent(encodeStr, closeQrComponent));
  }

  closeQrComponent(){
    OverlayManager().removeOverlay("qrViewComponent");
  }

}