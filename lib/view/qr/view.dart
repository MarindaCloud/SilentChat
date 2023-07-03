import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/back_button.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'logic.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrPage extends StatelessWidget {
  QrPage({Key? key}) : super(key: key);

  final logic = Get.find<QrLogic>();
  final state = Get
      .find<QrLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
      return SafeArea(
          child: Scaffold(
            body: Container(
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: MobileScanner(
                        fit: BoxFit.cover,
                        controller: state.qrController,
                        onDetect: (capture) {
                          dynamic value = capture.raw;
                          var result = value[0];
                          Log.i("扫码结果: ${result}");
                          state.qrValue = result["rawValue"];
                          logic.toUserInfo();
                          // Log.i("raw: ${capture.raw}");
                        },
                      ),
                    ),
                    Positioned(
                      top: 20,
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              child: SizedBox(
                                width: 150.rpx,
                                height: 150.rpx,
                                child: Image.asset(
                                  "assets/icon/back.png", color: Colors.white,
                                  fit: BoxFit.cover,),
                              ),
                              onTap: () {
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      width: Get.width,
                      bottom: 200,
                      // left: Get.width / 2,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 200.rpx),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              child: ValueListenableBuilder(
                                valueListenable: state.qrController.torchState,
                                builder: (BuildContext context, value, Widget? child) {
                                  return SizedBox(
                                    width: 150.rpx,
                                    height: 150.rpx,
                                    child: Image.asset(
                                      "assets/icon/shoudiantong.png",
                                      color: state.showFlash.value
                                          ? Colors.grey
                                          : Colors.white, fit: BoxFit.fill,),
                                  );
                                },
                              ),
                              onTap: () {
                                state.showFlash.value = !state.showFlash.value;
                                state.qrController.toggleTorch();
                              },
                            ),
                            InkWell(
                              child: ValueListenableBuilder(
                                valueListenable: state.qrController.cameraFacingState,
                                builder: (BuildContext context, value, Widget? child) {
                                  return SizedBox(
                                    width: 150.rpx,
                                    height: 150.rpx,
                                    child: Image.asset("assets/icon/qiehuan.png",
                                      color: state.viewType.value
                                          ? Colors.grey
                                          : Colors.white, fit: BoxFit.fill,),
                                  );
                                },
                              ),
                              onTap: () {
                                state.viewType.value = !state.viewType.value;
                                state.qrController.switchCamera();
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ),
          );
  }
}
