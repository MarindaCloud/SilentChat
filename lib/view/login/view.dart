import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final logic = Get.find<LoginLogic>();
  final state = Get
      .find<LoginLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.white,
          child: SafeArea(
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: 400.rpx,
                  ),
                  //头部
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(),
                        Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: SizedBox(
                                      width: 250.rpx,
                                      height: 210.rpx,
                                      child: Image.asset("assets/logo.jpg"),
                                    ),
                                  ),
                                  Container(
                                      child: Text("TIM", style: TextStyle(
                                          color: Colors.black, fontSize: 35),
                                      ))
                                ]
                            )),
                        Container()
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 200.rpx),
                    padding: EdgeInsets.only(left: 200.rpx, right: 200.rpx),
                    child: Column(
                      children: [
                        //账号框
                        Container(
                          margin: EdgeInsets.only(bottom: 50.rpx),
                          padding: EdgeInsets.only(left: 50.rpx,
                              right: 100.rpx,
                              top: 20.rpx,
                              bottom: 0.rpx),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(242, 243, 246, 1),
                              borderRadius: BorderRadius.circular(100000)
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 200.rpx,
                                height: 200.rpx,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1000),
                                    image: DecorationImage(
                                        image: Image
                                            .asset("assets/user/portait.png")
                                            .image,
                                        fit: BoxFit.fill
                                    )
                                ),
                              ),
                              SizedBox(
                                width: 150.rpx,
                              ),
                              Expanded(
                                  child: TextField(
                                    controller: state.userName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24
                                    ),
                                    maxLines: 1,
                                    maxLength: null,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(
                                            1000),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(
                                              1000)
                                      ),
                                    ),
                                  )),
                              Container(
                                width: 70.rpx,
                                height: 70.rpx,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: Image
                                            .asset("assets/icon/zhankai1.png",color: Color.fromRGBO(150, 150, 150, 1))
                                            .image,
                                        fit: BoxFit.fill
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                        //密码框
                        Container(
                          margin: EdgeInsets.only(bottom: 20.rpx),
                          padding: EdgeInsets.only(left: 50.rpx,
                              right: 100.rpx,
                              top: 20.rpx,
                              bottom: 0.rpx),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(242, 243, 246, 1),
                              borderRadius: BorderRadius.circular(100000)
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 200.rpx,
                                height: 200.rpx,
                              ),
                              SizedBox(
                                width: 150.rpx,
                              ),
                              Expanded(
                                  child: TextField(
                                    obscureText: true,
                                    controller: state.passWord,
                                    maxLines: 1,
                                    maxLength: null,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24
                                    ),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(
                                            1000),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(
                                              1000)
                                      ),
                                    ),
                                  )),
                              Container(
                                width: 40.rpx,
                                height: 40.rpx,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //协议
                  Container(
                    padding: EdgeInsets.only(left: 200.rpx, right: 200.rpx),
                    child: Row(
                      children: [
                        Container(
                          width: 200.rpx,
                          height: 200.rpx,
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
                                    child: Text("TIM隐私保护指引",style: TextStyle(fontSize: 12,color: Colors.blue)),
                                  onTap: (){
                                      print("tim协议保护");
                                  },
                                )
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                SizedBox(
                  height: 250.rpx,
                ),
                //  登入按钮
                  Center(
                    child: InkWell(
                      child: Container(
                        width: 400.rpx,
                        height: 400.rpx,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(89,192,247,1),
                                Color.fromRGBO(68,153,235,1),
                              ]
                          ),
                          borderRadius: BorderRadius.circular(10000)
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 150.rpx,
                            height: 150.rpx,
                            child: Image.asset("assets/icon/denglu.png",color: Colors.white,),
                          ),
                        ),
                      ),
                      onTap: (){
                        logic.login();
                      },
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    margin: EdgeInsets.only(bottom: 100.rpx),
                    padding: EdgeInsets.only(left: 200.rpx, right: 200.rpx),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border(right: BorderSide(color: Color.fromRGBO(230,230,230,1),width: 2))
                              ),
                              child: Container(
                                child: Text("手机号登录",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13)),
                              ),
                            )
                        ),
                        Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border(right: BorderSide(color: Color.fromRGBO(230,230,230,1),width: 2))                            ),
                              child: Container(
                                child: Text("新用户注册",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                              ),
                            )
                        ),
                        Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Container(
                                child: Text("更多选项",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                              ),
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
