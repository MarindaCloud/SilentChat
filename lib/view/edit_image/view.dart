import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/back_navigator.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/edit_image/state.dart';
import 'logic.dart';

/**
 * @author Marinda
 * @date 2023/7/20 14:55
 * @description 自定义图像编辑器
 */
class EditImagePage extends StatelessWidget {
  final EditImageLogic logic = Get.find<EditImageLogic>();
  final EditImageState state = Get.find<EditImageLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Container(
            color: Color.fromRGBO(245, 248, 250, 1),
            child: SafeArea(
              bottom: false,
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
                          Visibility(
                            visible: true,
                            child:state.cropWidget.value
                          ),
                          //  选择图片
                          Positioned(
                              left: 20,
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
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
        );
      }),
    );
  }
}
