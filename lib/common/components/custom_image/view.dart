import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/back_navigator.dart';
import 'package:silentchat/common/components/custom_image/state.dart';
import 'package:photo_view/photo_view.dart';
import 'package:silentchat/common/components/custom_image/widget/custom_canvas_paint.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'logic.dart';

/**
 * @author Marinda
 * @date 2023/7/20 14:55
 * @description 自定义图像编辑器
 */
class CustomImageComponent extends StatelessWidget {
  final CustomImageLogic logic;
  final CustomImageState state;
  final String src;
  final Function saveFun;

  CustomImageComponent(this.src, this.saveFun, {Key? key})
      :
        logic = Get.put(CustomImageLogic(src, saveFun)),
        state = Get
            .find<CustomImageLogic>()
            .state,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(245, 248, 250, 1),
        child: Obx(() {
          return SafeArea(
            child: Column(
              children: [
                //  头部内容
                BackNavigatorComponent(
                    "图片处理", logic.close, Colors.black, Colors.black),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    color: Colors.black,
                    child: Stack(
                      children: [
                        //图片信息
                        Positioned(
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: Get.width,
                                height: 500,
                                color: Colors.black,
                                child: Column(
                                  children: [
                                    Transform.scale(
                                        scale: state.scale.value,
                                        child: Image.network(
                                            state.src.value)
                                    ),
                                  ],
                                )
                            ),
                        ),
                        Visibility(
                          visible: state.showCustomWidget.value,
                          child: Positioned(
                            top: 0,
                            left: 0,
                            child: GestureDetector(
                              onTapDown: logic.onTapDown,
                              onScaleUpdate: logic.scaleUpdate,
                              child: Container(
                                width: Get.width - 5,
                                height: 250,
                                child: RepaintBoundary(
                                  child: CustomPaint(
                                    size: Size(Get.width - 5,250),
                                    painter: CustomCanvasPaint(state.customOffset.value,state.rectSize.value,
                                        state.showCustomWidget.value,state.customDirection),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //  裁剪
                        Positioned(
                            left: 20,
                            bottom: 20,
                            child: InkWell(
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                              ),
                              onTap: () {
                                Log.i("裁剪");
                                logic.showCustomWidget();
                              },
                            )
                        ),
                        //  保存
                        Positioned(
                            right: 20,
                            bottom: 20,
                            child: InkWell(
                              child: Container(
                                  width: 80,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                  ),
                                  child: Center(child: Text("上传",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),))),
                            )
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
