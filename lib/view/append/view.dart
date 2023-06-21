import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/back_button.dart';
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
        body: Container(
          color: logic.systemState.bodyColor,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    //  头部
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 100.rpx),
                      height: 200.rpx,
                      width: Get.width,
                      // color: Colors.white,
                      child: Row(
                        children: [
                          BackButtonComponent(onClick: Get.back),
                          Expanded(
                            child: TextField(
                              controller: state.accountTextController,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 14),
                              maxLines: null,
                              // maxLength: 11,
                              decoration: InputDecoration(
                                  label: SizedBox(
                                      width: 100.rpx,
                                      height: 100.rpx,
                                      child: Image.asset(
                                        "assets/icon/sousuo.png",
                                        fit: BoxFit.cover, color: Colors.grey,)
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "请输入目标IM号",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                  contentPadding: EdgeInsets.only(
                                      left: 20, right: 20),
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
                          SizedBox(width: 50.rpx),
                          //  查询按钮
                          Container(
                            height: 200.rpx,
                            color: Colors.white,
                            child: TextButton(
                              onPressed: logic.search,
                              child: Container(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 100.rpx,
                                      height: 100.rpx,
                                      child: Image.asset(
                                        "assets/icon/dynamic.png",
                                        fit: BoxFit.cover, color: Colors.grey,),
                                    ),
                                    SizedBox(
                                      width: 50.rpx,
                                    ),
                                    Text(
                                      "查询",
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 16,
                                          letterSpacing: 5.rpx),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 100.rpx),
                    //  查询结果
                    state.searchFlag.value ? buildSearchResult() : Container()
                  ],
                ),
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
    return SlideTransition(
        position: state.animation!,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 100.rpx),
            child: Wrap(
              children: logic.buildWidget(),
            ),
          )
        ],
      )
    );
  }
}
