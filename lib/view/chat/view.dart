import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/back_button.dart';
import 'package:silentchat/common/emoji.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'logic.dart';

/**
 * @author Marinda
 * @date 2023/5/26 10:25
 * @description 聊天页
 */
class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  final logic = Get.find<ChatLogic>();
  final state = Get
      .find<ChatLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          body: Container(
            color: Color.fromRGBO(247, 247, 247, 1),
            child: SafeArea(
              child: Container(
                child: Column(
                    children: [
                      //头部信息
                      Container(
                        child: Container(
                          padding: EdgeInsets.only(left: 80.rpx, right: 150
                              .rpx),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    child: Row(
                                      children: [
                                        //返回按钮
                                        BackButtonComponent(onClick: logic.back),
                                        //未读消息数
                                        Visibility(
                                          visible: logic.userState.messageMap.values.isNotEmpty,
                                          child: Transform.translate(
                                            offset: Offset(-5, 0),
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: 0.rpx),
                                              padding: EdgeInsets.all(5.rpx),
                                              width: 120.rpx,
                                              // height: 120.rpx,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(76,175,80,1),
                                                  borderRadius: BorderRadius
                                                      .circular(15000)
                                              ),
                                              child: Center(
                                                child: Text("${logic.userState.messageMap.values.length}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Text("${state.title}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18))
                                        )
                                      ],
                                    ),
                                  )
                              ),
                              InkWell(
                                child: Container(
                                  child: SizedBox(
                                    width: 80.rpx,
                                    height: 80.rpx,
                                    child: Image.asset("assets/icon/liebiao2.png",
                                      color: Colors.black,fit: BoxFit.fill,),
                                  ),
                                ),
                                onTap: logic.toEditFriendsInfo,
                              )
                            ],
                          ),
                        ),
                      ),
                      //内容信息
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(top: 50.rpx),
                                  color: Color.fromRGBO(241, 241, 241, 1),
                                  // color: Colors.red,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: logic.buildChatMessage(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //    底部
                      Container(
                        width: Get.width,
                        padding: EdgeInsets.only(top: 0.rpx, bottom: 0),
                        color: Color.fromRGBO(247, 247, 247, 1),
                        child: Column(
                          children: [
                            //输入框
                            Container(
                              height: 230.rpx,
                              padding: EdgeInsets.only(
                                  top: 50.rpx, left: 50.rpx, right: 50.rpx),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      maxLength: null,
                                      maxLines: null,
                                      style: TextStyle(
                                        fontSize: 16
                                      ),
                                      controller: state.messageController,
                                      onChanged: (val){
                                        if(val.isEmpty){state.existsContentFlag.value = false;return;}
                                        state.existsContentFlag.value = true;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 100.rpx, right: 50.rpx),
                                        fillColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(20),
                                            borderSide: BorderSide.none
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(20),
                                            borderSide: BorderSide.none
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 50.rpx,
                                  ),
                                  SizedBox(
                                    width: 250.rpx,
                                    height: 200.rpx,
                                    child: InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: state.existsContentFlag.value ? Colors.blue : Color.fromRGBO(182,182,182,1),
                                            borderRadius: BorderRadius
                                                .circular(5)
                                        ),
                                        child: Center(
                                          child: Text("发送",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),),
                                        ),
                                      ),
                                      onTap: () {
                                        logic.sendMessage();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30.rpx),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                children: [
                                  Container(
                                    child: InkWell(
                                      child: SizedBox(
                                        width: 150.rpx,
                                        height: 150.rpx,
                                        child: Image.asset(
                                          "assets/icon/luyin.png",
                                          color: state.subChildType.value == "luyin" ? Colors.blue :Colors.black,
                                          // color: Colors.black,
                                          fit: BoxFit.cover,),
                                      ),
                                      onTap: () {
                                        logic.chooseSubChild("luyin");
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: InkWell(
                                      child: SizedBox(
                                        width: 150.rpx,
                                        height: 150.rpx,
                                        child: Image.asset(
                                          "assets/icon/tuxiang.png",
                                          color: Colors.black,),
                                      ),
                                      onTap: () {
                                        logic.openImagePicker();
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: InkWell(
                                      child: SizedBox(
                                        width: 150.rpx,
                                        height: 150.rpx,
                                        child: Image.asset(
                                          "assets/icon/luzhishipin.png",
                                          color: Colors.black,),
                                      ),
                                      onTap: () {
                                        logic.openVideoPicker();
                                        // print("视频");
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: InkWell(
                                      child: SizedBox(
                                        width: 150.rpx,
                                        height: 150.rpx,
                                        child: Image.asset(
                                          "assets/icon/biaoqing.png",
                                          color: state.subChildType.value == "emote" ? Colors.blue :Colors.black,),
                                      ),
                                      onTap: () {
                                        logic.chooseSubChild("emote");
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: InkWell(
                                      child: SizedBox(
                                        width: 150.rpx,
                                        height: 150.rpx,
                                        child: Image.asset(
                                          "assets/icon/jiahao.png",
                                          color: Colors.black,),
                                      ),
                                      onTap: () {
                                        print("更多");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // 子组件
                            FadeTransition(
                              opacity: state.fadeValue!,
                              child: Visibility(
                                visible: state.chooseSubChild.value,
                                child: logic.buildSubWidget(),
                                // child: logic.buildEmojiWidget(),
                              ),
                            ),
                            Container(
                              height: 50.rpx,
                              color: Color.fromRGBO(247, 247, 247, 1),
                            )
                            // Expanded(child: SizedBox())
                          ],
                        ),
                      )
                    ]
                ),
              ),
            ),
          )
      );
    });
  }
}
