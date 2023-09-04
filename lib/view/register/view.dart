import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:flukit/flukit.dart';
import 'logic.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final logic = Get.find<RegisterLogic>();
  final state = Get
      .find<RegisterLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: SafeArea(
            child: Stack(
              children: [
                //头部返回
                //顶部
                Positioned(
                  top: 0.rpx,
                  left: 0,
                  child: Container(
                    width: Get.width,
                    child: Container(
                      child: SafeArea(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Transform.translate(
                                offset: Offset(30, 0),
                                child: Container(
                                    child: IconButtonComponent.build(
                                        "back", color: Colors.grey.withOpacity(.5),width: 130.rpx,height: 130.rpx,)),
                              ),
                              Center(
                                  child: Container(
                                      child: Text(
                                        "注册账号",
                                        style: TextStyle(fontSize: 20),
                                      ))),
                              SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: GetPlatform.isDesktop ?  50.rpx : 400.rpx,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0.rpx,right: 0.rpx),
                        padding: EdgeInsets.only(left: 0.rpx, right: 0.rpx),
                        child: Column(
                          children: [
                            //账号框
                            Container(
                              margin: EdgeInsets.only(left: 50.rpx,right: 50.rpx ,bottom: 50.rpx),
                              padding: EdgeInsets.only(left: 50.rpx,
                                  right: 100.rpx,
                                  top: 20.rpx,
                                  bottom: 0.rpx),
                              child: AfterLayout(
                                callback: logic.userNameReaderLayoutInfo,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Text("用户名：",style: TextStyle(color: Colors.black,fontSize: 16,letterSpacing: 5),),
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                            height: 200.rpx,
                                            child: TextField(
                                              controller: state.userName,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16
                                              ),
                                              maxLines: 1,
                                              maxLength: null,
                                              decoration: InputDecoration(
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey,width: 1)
                                                ),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.grey,width: 1)
                                                  ),
                                                contentPadding: EdgeInsets.only(left: 50.rpx,right: 50.rpx)
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //密码框
                            Container(
                              margin: EdgeInsets.only(left: 50.rpx,right: 50.rpx ,bottom: 50.rpx),
                              padding: EdgeInsets.only(left: 50.rpx,
                                  right: 100.rpx,
                                  top: 20.rpx,
                                  bottom: 0.rpx),
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text("密码：",style: TextStyle(color: Colors.black,fontSize: 16,letterSpacing: 12),),
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                          height: 200.rpx,
                                          child: TextField(
                                            controller: state.passWord,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16
                                            ),
                                            maxLines: 1,
                                            maxLength: null,
                                            decoration: InputDecoration(
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.grey,width: 1)
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.grey,width: 1)
                                                ),
                                                contentPadding: EdgeInsets.only(left: 50.rpx,right: 50.rpx)
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            //邮箱
                            Container(
                              margin: EdgeInsets.only(left: 50.rpx,right: 50.rpx ,bottom: 50.rpx),
                              padding: EdgeInsets.only(left: 50.rpx,
                                  right: 100.rpx,
                                  top: 20.rpx,
                                  bottom: 0.rpx),
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text("邮箱：",style: TextStyle(color: Colors.black,fontSize: 16,letterSpacing: 12),),
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                          height: 200.rpx,
                                          child: TextField(
                                            controller: state.email,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16
                                            ),
                                            maxLines: 1,
                                            maxLength: null,
                                            decoration: InputDecoration(
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.grey,width: 1)
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.grey,width: 1)
                                                ),
                                                contentPadding: EdgeInsets.only(left: 50.rpx,right: 50.rpx)
                                            ),
                                          ),
                                        )),
                                    Container(
                                      height: 200.rpx,
                                      margin: EdgeInsets.only(left: 100.rpx),
                                      padding: EdgeInsets.only(left: 30.rpx,right: 30.rpx),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color.fromRGBO(89,192,247,1),
                                              Color.fromRGBO(68,153,235,1),
                                            ]
                                        ),
                                      ),
                                      child: Center(
                                        child: Text("发送",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 5),),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //验证码
                            Container(
                              margin: EdgeInsets.only(left: 50.rpx,right: 50.rpx ,bottom: 50.rpx),
                              padding: EdgeInsets.only(left: 50.rpx,
                                  right: 100.rpx,
                                  top: 20.rpx,
                                  bottom: 0.rpx),
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text("验证码：",style: TextStyle(color: Colors.black,fontSize: 16,letterSpacing: 5),),
                                    ),
                                    SizedBox(
                                      width: 500.rpx,
                                      height: 200.rpx,
                                      child: TextField(
                                        controller: state.verify,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16
                                        ),
                                        maxLines: 1,
                                        maxLength: null,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey,width: 1)
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey,width: 1)
                                            ),
                                            contentPadding: EdgeInsets.only(left: 50.rpx,right: 50.rpx)
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // //协议
                      Container(
                        padding: EdgeInsets.only(left: 150.rpx, right: 50.rpx),
                        child: Row(
                          children: [
                            Container(
                              width: 200.rpx,
                              height: GetPlatform.isDesktop ?  100.rpx : 200.rpx,
                            ),
                            InkWell(
                              child: Container(
                                width: 80.rpx,
                                height: 80.rpx,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey, width: 2),
                                    borderRadius: BorderRadius.circular(10000),
                                    color: state.accept.value ?Colors.blue:Colors.white
                                ),
                              ),
                              onTap: () {
                                state.accept.value = !state.accept.value;
                              },
                            ),
                            SizedBox(width: 5),
                            Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                        child: Text("已阅读并同意",style: TextStyle(fontSize: 12,color: Colors.grey))),
                                    InkWell(
                                      child: Text("服务协议",style: TextStyle(fontSize: 12,color: Colors.blue)
                                      ),
                                      onTap: (){
                                        print("服务协议");
                                      },
                                    ),
                                    Text("和",style: TextStyle(fontSize: 12,color: Colors.grey)),
                                    InkWell(
                                      child: Text("默讯保护指引",style: TextStyle(fontSize: 12,color: Colors.blue)),
                                      onTap: (){
                                        print("默讯协议保护");
                                      },
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: GetPlatform.isDesktop ?  50.rpx : 0.rpx,
                      ),
                      //  登入按钮
                      Container(
                        margin: EdgeInsets.only(left: 50.rpx,right: 50.rpx ,bottom: 50.rpx,top: 50.rpx),
                        child: InkWell(
                          child: FractionallySizedBox(
                            widthFactor: .9,
                            child: Container(

                              // width: 500.rpx,
                              height: 200.rpx,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color.fromRGBO(89,192,247,1),
                                        Color.fromRGBO(68,153,235,1),
                                      ]
                                  ),
                                  borderRadius: BorderRadius.circular(5.rpx)
                              ),
                              child: Center(
                                child: Text("注册",style: TextStyle(color: Colors.white,fontSize: 20,letterSpacing: 5),),
                              ),
                            ),
                          ),
                          onTap: (){print("注册");},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
