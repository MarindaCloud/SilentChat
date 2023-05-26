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
  final state = Get.find<ChatLogic>().state;

  @override
  Widget build(BuildContext context) {
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
                    padding: EdgeInsets.only(left: 80.rpx,right: 150.rpx),
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
                                    offset: Offset(-5,0),
                                    child: Container(
                                      margin: EdgeInsets.only(right: 0.rpx),
                                      padding: EdgeInsets.all(5.rpx),
                                      width: 120.rpx,
                                      height: 120.rpx,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(199,199,202,1),
                                          borderRadius: BorderRadius.circular(15000)
                                      ),
                                      child: Center(
                                        child: Text("17",style: TextStyle(color: Colors.black,fontSize: 18)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Text("工作群(2)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18))
                                  )
                                ],
                              ),
                            )
                        ),
                        Container(
                          child: SizedBox(
                            width: 80.rpx,
                            height: 80.rpx,
                            child: Image.asset("assets/icon/liebiao2.png",color: Colors.black,),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //内容信息
                Container(
                  margin: EdgeInsets.only(top: 190.rpx),
                  color: Color.fromRGBO(241,241,241,1),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: logic.buildChatMessage(),
                      ),
                    ),
                  ),
                ),
                //    底部
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: Get.width,
                    height: 600.rpx,
                    padding: EdgeInsets.only(top: 0.rpx,bottom: 0),
                    color: Color.fromRGBO(211,211,211,1),
                    child: Column(
                      children: [
                        //输入框
                        Container(
                          height: 230.rpx,
                          padding: EdgeInsets.only(top: 50.rpx,left: 50.rpx,right: 50.rpx),
                          child: SizedBox(
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 100.rpx),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30.rpx),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: InkWell(
                                  child: SizedBox(
                                    width: 150.rpx,
                                    height: 150.rpx,
                                    child: Image.asset("assets/icon/luyin.png",color: Colors.black,fit: BoxFit.cover,),
                                  ),
                                  onTap: (){
                                    print("录音");
                                  },
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  child: SizedBox(
                                    width: 150.rpx,
                                    height: 150.rpx,
                                    child: Image.asset("assets/icon/tuxiang.png",color: Colors.black,),
                                  ),
                                  onTap: (){
                                    print("图像");
                                  },
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  child: SizedBox(
                                    width: 150.rpx,
                                    height: 150.rpx,
                                    child: Image.asset("assets/icon/luzhishipin.png",color: Colors.black,),
                                  ),
                                  onTap: (){
                                    print("视频");
                                  },
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  child: SizedBox(
                                    width: 150.rpx,
                                    height: 150.rpx,
                                    child: Image.asset("assets/icon/biaoqing.png",color: Colors.black,),
                                  ),
                                  onTap: (){
                                    print("表情");
                                  },
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  child: SizedBox(
                                    width: 150.rpx,
                                    height: 150.rpx,
                                    child: Image.asset("assets/icon/jiahao.png",color: Colors.black,),
                                  ),
                                  onTap: (){
                                    print("更多");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
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
  }
}
