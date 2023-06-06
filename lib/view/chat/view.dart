import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/back_button.dart';
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
            color: Color.fromRGBO(211, 211, 211, 1),
            child: SafeArea(
              bottom: false,
              child: Container(
                child: Stack(
                    children: [
                      //头部信息
                      Container(
                        height: 150.rpx,
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
                                        BackButtonComponent(),
                                        //未读消息数
                                        Transform.translate(
                                          offset: Offset(-5, 0),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 0.rpx),
                                            padding: EdgeInsets.all(5.rpx),
                                            width: 120.rpx,
                                            height: 120.rpx,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    199, 199, 202, 1),
                                                borderRadius: BorderRadius
                                                    .circular(15000)
                                            ),
                                            child: Center(
                                              child: Text("17",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18)),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Text("工作群(2)",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18))
                                        )
                                      ],
                                    ),
                                  )
                              ),
                              Container(
                                child: SizedBox(
                                  width: 80.rpx,
                                  height: 80.rpx,
                                  child: Image.asset("assets/icon/liebiao2.png",
                                    color: Colors.black,),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      //内容信息
                      Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 190.rpx),
                                color: Color.fromRGBO(241, 241, 241, 1),
                                // color: Colors.red,
                                child: SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                      children: logic.buildChatMessage(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //    底部
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: Get.width,
                          padding: EdgeInsets.only(top: 0.rpx, bottom: 0),
                          color: Color.fromRGBO(211, 211, 211, 1),
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
                                        controller: state.messageController,
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
                                              color: Colors.blue,
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
                                            color: Colors.black,
                                            fit: BoxFit.cover,),
                                        ),
                                        onTap: () {
                                          logic.recording();
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
                                            color: Colors.black,),
                                        ),
                                        onTap: () {
                                          print("表情");
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
                              //录音
                              FadeTransition(
                                opacity: state.fadeValue!,
                                child: Visibility(
                                  visible: state.chooseRecording.value,
                                  child: Center(
                                    child: Container(
                                      color: Colors.white,
                                      margin: EdgeInsets.only(top: 50.rpx),
                                      child: Center(
                                        child: Container(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 50.rpx,
                                              ),
                                              Container(
                                                child: Text("按住说话",
                                                  style: TextStyle(
                                                      color: Colors.grey),),
                                              ),
                                              SizedBox(
                                                height: 100.rpx,
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(10000),
                                                      color: Colors.blue
                                                  ),
                                                  width: 300.rpx,
                                                  height: 300.rpx,
                                                  child: Center(child: Container(
                                                    width: 200.rpx,
                                                    height: 200.rpx,
                                                    child: Image.asset(
                                                      "assets/icon/luyin.png",
                                                      color: Colors.white,
                                                      fit: BoxFit.cover,),
                                                  ),)
                                              ),
                                              //
                                              Container(
                                                height: 100.rpx,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 100.rpx,
                                color: Color.fromRGBO(211, 211, 211, 1),
                              )
                              // Expanded(child: SizedBox())
                            ],
                          ),
                        ),
                      )
                    ]
                ),
              ),
            ),
          ));
    });
  }
}
