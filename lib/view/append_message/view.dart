import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/back_button.dart';
import 'package:silentchat/common/expansion/image_path.dart';
import 'package:silentchat/util/date_time_util.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'logic.dart';

class AppendMessagePage extends StatelessWidget {
  AppendMessagePage({Key? key}) : super(key: key);

  final logic = Get.put(AppendMessageLogic());
  final state = Get
      .find<AppendMessageLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Container(
          padding: EdgeInsets.all(15),
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    //头部
                    Container(
                        margin: EdgeInsets.only(left: 30.rpx),
                        alignment: Alignment.topLeft,
                        height: 100.rpx,
                        child: BackButtonComponent()
                    ),
                    SizedBox(height: 50.rpx),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //目标基础信息
                          Container(
                            // width: 600.rpx,
                            child: Column(
                              children: [
                                //头像
                                Container(
                                  width: 500.rpx,
                                  height: 500.rpx,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10000),
                                      image: DecorationImage(
                                          image: Image
                                              .asset(getPortrait())
                                              .image,
                                          fit: BoxFit.fill
                                      )
                                  ),
                                ),
                                //签名 / 介绍
                                Visibility(
                                  visible: state.type.value == 1,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 50.rpx),
                                    child: Text("个性签名：${getDescription()}",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 50.rpx,
                                ),
                                //性别和其他信息
                                Visibility(
                                  visible: state.type.value == 1,
                                  child: Container(
                                    child: Row(
                                      children: [
                                        //性别信息
                                        Container(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                  width: 80.rpx,
                                                  height: 80.rpx,
                                                  child: Image.asset(
                                                      logic.userLogic
                                                          .getSex() == "男"
                                                          ? "man.png".icon
                                                          : "woman.png".icon,
                                                      color: logic.userLogic
                                                          .getSex() == "男"
                                                          ? Colors.blue
                                                          : Colors.pink,
                                                      fit: BoxFit.fill)
                                              ),
                                              SizedBox(width: 10.rpx),
                                              Text(logic.userLogic.getSex(),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16)
                                              ),
                                            ],
                                          ),
                                        ),
                                        //年龄
                                        Container(
                                          margin: EdgeInsets.only(left: 50.rpx),
                                          padding: EdgeInsets.only(
                                              right: 50.rpx),
                                          child: Text(
                                            "${logic.userLogic.getAge()}岁",
                                            style: TextStyle(color: Colors.grey,
                                                fontSize: 16),),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50.rpx,
                                ),
                                //月份，星座
                                Visibility(
                                  visible: state.type == 1,
                                  child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Container(
                                            child: Text(
                                                logic.userLogic.getDate(),
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16)),
                                          ),
                                          SizedBox(width: 50.rpx),
                                          Container(
                                            child: Text(
                                              DateTimeUtil.getConstellAtion(
                                                  logic.userState.user.value
                                                      ?.birthday ?? DateTime.now()),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                SizedBox(
                                  height: 50.rpx,
                                ),
                                //国家 具体到省市
                                Visibility(
                                  visible: state.type == 1,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Container(
                                          child: Text(
                                              logic.userLogic.getProvince(),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16)),
                                        ),
                                        Container(
                                          child: Text(
                                            logic.userLogic.getCity(),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16),),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                //  人数
                                if (state.type == 2)
                                  Container(
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: "1",
                                          style: TextStyle(color: Colors.grey,
                                              fontSize: 14)),
                                      TextSpan(
                                          text: "/",
                                          style: TextStyle(color: Colors.grey,
                                              fontSize: 14)),
                                      TextSpan(
                                          text: state.element.personMax,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14))
                                    ])),
                                  )
                              ],
                            ),
                          ),
                          Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 30.rpx),
                                child: Column(
                                  children: [
                                    //  文本框，验证消息
                                    SizedBox(
                                      // height: 500.rpx,
                                      child: TextField(
                                        controller: state.controller,
                                        decoration: InputDecoration(
                                            hintText: "验证消息",
                                            enabled: true,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        267, 267, 267, 1),
                                                    width: 1)),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        267, 267, 267, 1),
                                                    width: 1))),
                                        maxLines: 10,
                                        maxLength: null,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16
                                        ),
                                      ),
                                    ),
                                    // Expanded(child: SizedBox()),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 100.rpx),
                      width: Get.width,
                      height: 200.rpx,
                      child: Container(
                        color: Colors.blue,
                        child: TextButton(
                            onPressed: () async{
                              Log.i("发送申请");
                              await logic.sendFriendsVerify();
                            },
                            child: Text("添加好友！", style: TextStyle(
                                color: Colors.white, fontSize: 16),)
                        ),
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      );
    });
  }

  /*
   * @author Marinda
   * @date 2023/6/26 16:11
   * @description 根据type获取签名或者描述
   */
  String getDescription() {
    return state.type.value == 1
        ? state.element.signature ?? ""
        : state.element.description ?? "";
  }

  /*
   * @author Marinda
   * @date 2023/6/26 16:36
   * @description 获取头像
   */
  String getPortrait() {
    return state.type.value == 1 ? "assets/user/portait.png" : state.element
        .portrait;
  }
}
