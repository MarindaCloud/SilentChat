import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'logic.dart';

class SpacePage extends StatelessWidget {
  SpacePage({Key? key}) : super(key: key);

  final logic = Get.find<SpaceLogic>();
  final state = Get.find<SpaceLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          padding:
              EdgeInsets.only(left: 100.rpx, right: 100.rpx, bottom: 50.rpx),
          height: 900.rpx,
          decoration: BoxDecoration(
              // image: DecorationImage(
              //     image: Image.network("http://175.24.177.189:8080/assets/cb7936ec-a02d-48ac-ad46-f1782d53d4e1.png").image,
              //     fit: BoxFit.fill
              // ),
              color: Color.fromRGBO(239, 241, 253, 1)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            //背景底图
            Container(
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 50.rpx),
                        child: IconButtonComponent("back", Colors.white)),
                    Center(
                        child: Container(
                            child: Text(
                      "好友动态",
                      style: TextStyle(fontSize: 17),
                    ))),
                    SizedBox(),
                  ],
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              margin: EdgeInsets.only(left: 50.rpx),
              child: Row(
                children: [
                  //头像
                  Container(
                    width: 300.rpx,
                    height: 300.rpx,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10000),
                        image: DecorationImage(
                            image: Image.network(
                                    "http://175.24.177.189:8080/assets/cb7936ec-a02d-48ac-ad46-f1782d53d4e1.png")
                                .image,
                            fit: BoxFit.cover)),
                  ),
                ],
              ),
            )
          ]),
        ),
        //相关导航
        Container(
          padding: EdgeInsets.only(
              left: 180.rpx, right: 180.rpx, top: 80.rpx, bottom: 50.rpx),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color.fromRGBO(235, 235, 235, 1)))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //相册
              InkWell(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 30.rpx),
                        child: SizedBox(
                          width: 120.rpx,
                          height: 120.rpx,
                          child: Image.asset(
                            "assets/icon/tuxiang.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "相册",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  print("相册");
                },
              ),
              //说说
              InkWell(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 30.rpx),
                        child: SizedBox(
                          width: 130.rpx,
                          height: 130.rpx,
                          child: Image.asset(
                            "assets/icon/xiaoxiqipao.png",
                            fit: BoxFit.fill,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "说说",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  print("说说");
                },
              ),
              //相册
              InkWell(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 30.rpx),
                        child: SizedBox(
                          width: 130.rpx,
                          height: 130.rpx,
                          child: Image.asset(
                            "assets/icon/pifu.png",
                            fit: BoxFit.fill,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "个性化",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  print("个性化");
                },
              ),
              //相册
              InkWell(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 30.rpx),
                        child: SizedBox(
                          width: 130.rpx,
                          height: 130.rpx,
                          child: Image.asset(
                            "assets/icon/tuxiang.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "相册",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  print("相册");
                },
              ),
              //相册
              InkWell(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 30.rpx),
                        child: SizedBox(
                          width: 130.rpx,
                          height: 130.rpx,
                          child: Image.asset(
                            "assets/icon/tuxiang.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "相册",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  print("相册");
                },
              )
            ],
          ),
        ),
        //内容
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 80.rpx),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //动态
                  Container(
                    width: Get.width,
                    child: Column(
                      children: [
                        //  用户详情
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30.rpx),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 200.rpx,
                                      height: 200.rpx,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10000),
                                          image: DecorationImage(
                                              image: Image.network(
                                                      "http://175.24.177.189:8080/assets/cb7936ec-a02d-48ac-ad46-f1782d53d4e1.png")
                                                  .image,
                                              fit: BoxFit.fill)),
                                      margin: EdgeInsets.only(right: 50.rpx),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.only(bottom: 10.rpx),
                                            child: Text(
                                              "理工学院万能墙",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "今天14:36",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                              textAlign: TextAlign.start,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuButton(
                                itemBuilder: (context) {
                                  return <PopupMenuEntry<String>>[
                                    PopupMenuItem(
                                      child: Text("编辑",
                                          style: TextStyle(fontSize: 14)),
                                      value: "编辑",
                                      onTap: () {
                                        print("编辑");
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: Text("删除",
                                          style: TextStyle(fontSize: 14)),
                                      value: "编辑",
                                      onTap: () {
                                        print("编辑");
                                      },
                                    ),
                                  ];
                                },
                                icon: SizedBox(
                                  width: 150.rpx,
                                  height: 150.rpx,
                                  child: Image.asset(
                                    "assets/icon/gengduo.png",
                                    fit: BoxFit.fill,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //内容
                        Container(
                          margin: EdgeInsets.only(top: 50.rpx),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 10.rpx),
                                  height: 700.rpx,
                                  child: Image.network(
                                    "http://175.24.177.189:8080/assets/cb7936ec-a02d-48ac-ad46-f1782d53d4e1.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 700.rpx,
                                  child: Image.network(
                                    "http://175.24.177.189:8080/assets/cb7936ec-a02d-48ac-ad46-f1782d53d4e1.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //  图标组
                        Container(
                          margin: EdgeInsets.only(top: 30.rpx),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 80.rpx),
                                child: InkWell(
                                  child: SizedBox(
                                    width: 130.rpx,
                                    height: 130.rpx,
                                    child: Image.asset("assets/icon/good.png",
                                        fit: BoxFit.fill),
                                  ),
                                  onTap: () {
                                    print("点赞");
                                  },
                                ),
                              ),
                              InkWell(
                                child: SizedBox(
                                  width: 130.rpx,
                                  height: 130.rpx,
                                  child: Image.asset(
                                    "assets/icon/xiaoxiqipao.png",
                                    fit: BoxFit.fill,
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  print("评论");
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 50.rpx),
                                child: InkWell(
                                  child: SizedBox(
                                    width: 80.rpx,
                                    height: 80.rpx,
                                    child: Image.asset(
                                      "assets/icon/good.png",
                                      fit: BoxFit.fill,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  onTap: (){
                                    print("打开点赞列表");
                                  },
                                ),
                              ),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "测试、",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14
                                          ),
                                          recognizer: TapGestureRecognizer(
                                          )..onTap = (){
                                            print("测试");}
                                      ),
                                      TextSpan(
                                          text: "测试员工、",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14
                                          ),
                                          recognizer: TapGestureRecognizer(
                                          )..onTap = (){
                                            print("测试");}
                                      ),
                                      TextSpan(
                                          text: "测试员工2、",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14
                                          ),
                                          recognizer: TapGestureRecognizer(
                                          )..onTap = (){
                                            print("测试");}
                                      ),
                                      TextSpan(
                                          text: "测试员工4、",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14
                                          ),
                                          recognizer: TapGestureRecognizer(
                                          )..onTap = (){
                                            print("测试");}
                                      ),
                                      TextSpan(
                                          text: "测试员工5、",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14
                                          ),
                                          recognizer: TapGestureRecognizer(
                                          )..onTap = (){
                                            print("测试");}
                                      ),
                                      TextSpan(
                                          text: "等106个人觉得很赞",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16
                                          ),
                                      ),
                                    ]
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.clip,),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
