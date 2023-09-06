import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/back_navigator.dart';
import 'package:silentchat/common/components/custom_image/state.dart';
import 'package:photo_view/photo_view.dart';
import 'package:silentchat/common/components/custom_image/widget/custom_canvas_paint.dart';
import 'package:silentchat/common/components/get_bind_widget.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'logic.dart';
import 'package:crop_image/crop_image.dart';

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
    return GetBindWidget(
      bind: logic,
      child: Obx(() {
        return Scaffold(
          body: Container(
              color: Color.fromRGBO(245, 248, 250, 1),
              child: SafeArea(
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
                            //  选择图片
                            Positioned(
                                left: 70,
                                bottom: 20,
                                child: Container(
                                  child: InkWell(
                                    child: SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: Image.asset(
                                        "assets/icon/tuxiang.png",
                                        fit: BoxFit.fill,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      logic.pickPortrait();
                                    },
                                  ),
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
                                            color: Colors.white,
                                            fontSize: 14),))),
                                  onTap: logic.save,
                                )
                            ),
                            Visibility(
                              // visible: state.showCustomWidget.value,
                              visible: true,
                              child: Container(
                                child: CropImage(
                                  /// Only needed if you expect to make use of its functionality like setting initial values of
                                  /// [aspectRatio] and [defaultCrop].
                                  controller: state.controller,

                                  /// The image to be cropped. Use [Image.file] or [Image.network] or any other [Image].
                                  image: state.src.value.startsWith("http") ? Image.network(src, fit: BoxFit.fill) : Image.asset(src,fit: BoxFit.fill,),

                                  /// The crop grid color of the outer lines. Defaults to 70% white.
                                  gridColor: Colors.white,

                                  /// The size of the corner of the crop grid. Defaults to 25.
                                  gridCornerSize: 5,

                                  /// The width of the crop grid thin lines. Defaults to 2.
                                  gridThinWidth: 3,

                                  /// The width of the crop grid thick lines. Defaults to 5.
                                  gridThickWidth: 5,

                                  /// The crop grid scrim (outside area overlay) color. Defaults to 54% black.
                                  scrimColor: Colors.grey.withOpacity(0.5),

                                  /// True: Always show third lines of the crop grid.
                                  /// False: third lines are only displayed while the user manipulates the grid (default).
                                  alwaysShowThirdLines: false,

                                  /// Event called when the user changes the crop rectangle.
                                  /// The passed [Rect] is normalized between 0 and 1.
                                  onCrop: (rect) => print(rect),

                                  /// The minimum pixel size the crop rectangle can be shrunk to. Defaults to 100.
                                  minimumImageSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),
        );
      }),
    );
  }
}
