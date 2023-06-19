import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'logic.dart';

/*
 * @author Marinda
 * @date 2023/6/19 17:15
 * @description 添加好友/群聊的页面
 */
class AppendPage extends StatelessWidget {
  AppendPage({Key? key}) : super(key: key);

  final logic = Get.find<AppendLogic>();
  final state = Get
      .find<AppendLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: logic.systemState.bodyColor,
            child: SafeArea(
              child: Column(
                children: [
                  //  头部
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 100.rpx),
                    height: 200.rpx,
                    width: Get.width,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Text("IM号："),
                        Expanded(
                          child: TextField(
                            controller: state.accountTextController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: logic.systemState.bodyColor,
                                        width: 1)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: logic.systemState.bodyColor,
                                        width: 1)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1)
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100.rpx),
                  //  查询按钮
                  Container(
                    height: 200.rpx,
                    color: Color.fromRGBO(84, 176, 247, 1),
                    child: Center(
                      child: Text("查询", style: TextStyle(color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 5.rpx),),
                    ),
                  ),
                  //  查询结果
                  buildSearchResult()
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  /*
   * @author Marinda
   * @date 2023/6/19 17:42
   * @description 构建查询结果
   */
  buildSearchResult() {
    return Container(
      child: Column(
        children: [
          //  文字提示
          Container(
            child: Text(
              "查询结果如下：",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 20
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 100.rpx,
                ),
                children: [

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
