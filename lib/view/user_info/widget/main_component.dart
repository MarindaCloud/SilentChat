import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/user_info/logic.dart';
import 'package:silentchat/view/user_info/state.dart';

/**
 * @author Marinda
 * @date 2023/6/21 14:48
 * @description 主要内容组件
 */
class MainComponent extends StatefulWidget {

  final UserInfoLogic userInfoLogic;
  final UserInfoState userInfoState;

  MainComponent(this.userInfoLogic, this.userInfoState);

  @override
  State<StatefulWidget> createState() {
    return MainComponentState();
  }
}

class MainComponentState extends State<MainComponent> {

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              //头像 & 基础信息
              Container(
                margin: EdgeInsets.only(bottom: 50.rpx),
                height: 300.rpx,
                child: Row(
                  children: [
                    Container(
                      width: 300.rpx,
                      height: 300.rpx,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10000),
                          image: DecorationImage(
                              image: Image
                                  .asset("assets/user/portait.png")
                                  .image,
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    SizedBox(
                      width: 70.rpx,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "${widget.userInfoState.user.value.username}",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 50.rpx),
                          Container(
                            child: Text.rich(
                                TextSpan(
                                    children: [
                                      TextSpan(text: "SCID: ",
                                          style: TextStyle(color: Colors.grey,
                                              fontSize: 16)),
                                      TextSpan(
                                          text: "${widget.userInfoState.user
                                              .value.number}",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16))
                                    ]
                                )
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //性别和其他信息
              Container(
                child: Row(
                  children: [
                    //性别信息
                    Container(
                      padding: EdgeInsets.only(right: 50.rpx),
                      decoration: BoxDecoration(
                          border: Border(right: BorderSide(
                              color: Color.fromRGBO(207, 207, 207, 1),
                              width: 1))
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 80.rpx,
                              height: 80.rpx,
                              child: Image.asset(
                                  "assets/icon/man.png", color: Colors.blue,
                                  fit: BoxFit.fill)
                          ),
                          SizedBox(width: 10.rpx),
                          Text("男",
                              style: TextStyle(color: Colors.grey, fontSize: 16)
                          )
                        ],
                      ),
                    ),
                    //年龄
                    Container(
                      margin: EdgeInsets.only(left: 50.rpx),
                      padding: EdgeInsets.only(right: 50.rpx),

                      decoration: BoxDecoration(
                          border: Border(right: BorderSide(
                              color: Color.fromRGBO(207, 207, 207, 1),
                              width: 1))),
                      child: Text(
                        "20岁",
                        style: TextStyle(color: Colors.grey, fontSize: 16),),
                    ),
                    //月份，星座
                    Container(
                        margin: EdgeInsets.only(left: 50.rpx),
                        padding: EdgeInsets.only(right: 50.rpx),
                        decoration: BoxDecoration(
                            border: Border(right: BorderSide(
                                color: Color.fromRGBO(207, 207, 207, 1),
                                width: 1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Text("1月1日", style: TextStyle(
                                  color: Colors.grey, fontSize: 16)),
                            ),
                            SizedBox(width: 50.rpx),
                            Container(
                              child: Text("摩羯座",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16),),
                            )
                          ],
                        )
                    ),
                    //国家 具体到省市
                    Container(
                        margin: EdgeInsets.only(left: 50.rpx),
                        padding: EdgeInsets.only(right: 50.rpx),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text("广东", style: TextStyle(
                                  color: Colors.grey, fontSize: 16)),
                            ),
                            SizedBox(width: 50.rpx),
                            Container(
                              child: Text("广州",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16),),
                            )
                          ],
                        )
                    )
                  ],
                ),
              ),
              SizedBox(height: 50.rpx),
              //  个签
              Container(
                alignment: Alignment.topLeft,
                child: Text.rich(
                    TextSpan(
                        children: [
                          TextSpan(text: "个性签名：",
                              style: TextStyle(fontSize: 16, color: Colors
                                  .grey)),
                          TextSpan(text: "这个人很懒，没有留下任何痕迹！",
                              style: TextStyle(color: Colors.black,
                                  fontSize: 16))
                        ]
                    )
                ),
              ),
              SizedBox(height: 30.rpx),
              //个人世界
              TextButton(
                child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70.rpx,
                                height: 70.rpx,
                                child: Image.asset(
                                  "assets/icon/dynamic.png", fit: BoxFit.fill,
                                  color: Colors.orange,),
                              ),
                              SizedBox(width: 30.rpx),
                              Expanded(child: Text(
                                "${widget.userInfoState.user.value
                                    .username}的世界", style: TextStyle(
                                  color: Colors.grey, fontSize: 16),)),
                            ],
                          ),
                        ),
                        IconButtonComponent("qianwang", Colors.grey)
                      ],
                    )
                ),
                onPressed: () {
                  Log.i(
                      "进入${widget.userInfoState.user.value.username}的世界");
                },
              )
            ],
          ),
        ),
      );
    });
  }

}