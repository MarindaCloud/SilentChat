import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/common/expansion/image_path.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'logic.dart';

/**
 * @author Marinda
 * @date 2023/11/20 17:01
 * @description 忘记密码
 */
class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  final logic = Get.find<ForgotPasswordLogic>();
  final state = Get.find<ForgotPasswordLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Container(
          color: Color.fromRGBO(239, 241, 253, 1),
          child: SafeArea(
            child: Stack(
              children: [
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
                                    child: IconButtonComponent(
                                        "back", Colors.grey.withOpacity(.7))),
                              ),
                              Center(
                                  child: Container(
                                      child: Text(
                                "找回密码",
                                style: TextStyle(fontSize: 17),
                              ))),
                              SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 300.rpx,
                  width: Get.width,
                  child: Container(
                    margin: EdgeInsets.only(left: 100.rpx, right: 100.rpx),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //第一步
                        Visibility(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          "请输入你的默讯号：",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        height: 150.rpx,
                                        child: TextField(
                                          controller: state.accountController,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1)),
                                          ),
                                          maxLength: null,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                                //按钮处理
                                Container(
                                  margin: EdgeInsets.only(top: 100.rpx),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: FractionallySizedBox(
                                          widthFactor: 1,
                                          child: InkWell(
                                            child: Container(
                                              height: 150.rpx,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                child: Text(
                                                  "下一步",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onTap: () => logic.sendVerifyCode(),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          visible: state.step.value == 1,
                        ),
                        //第二步
                        Visibility(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //tips
                                Container(
                                  child: Text(
                                    "我们已经向你发送一条邮件，填写正确验证码即可找回账户！",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                                //验证码
                                Container(
                                  margin: EdgeInsets.only(top: 100.rpx),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "验证码：",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                      //
                                      Expanded(
                                        child: SizedBox(
                                          height: 150.rpx,
                                          child: TextField(
                                            controller:
                                                state.verifyCodeController,
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        borderSide:
                                                            BorderSide(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        borderSide: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1)),
                                                contentPadding: EdgeInsets.only(
                                                    left: 50.rpx,
                                                    top: 5.rpx,
                                                    bottom: 5.rpx,
                                                    right: 50.rpx),
                                                hintText: "请输入验证码",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16)),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                //按钮处理
                                Container(
                                  margin: EdgeInsets.only(top: 100.rpx),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: FractionallySizedBox(
                                          widthFactor: 1,
                                          child: InkWell(
                                            child: Container(
                                              height: 150.rpx,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                child: Text(
                                                  "上一步",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onTap: () => logic.toStep(1),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 300.rpx),
                                      Expanded(
                                        child: FractionallySizedBox(
                                          widthFactor: 1,
                                          child: InkWell(
                                            child: Container(
                                              height: 150.rpx,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                child: Text(
                                                  "下一步",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onTap: ()=>logic.toResetPwd(),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          visible: state.step.value == 2,
                        ),
                        //第三步
                        Visibility(
                          visible: state.step.value == 3,
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  child: Center(
                                    child: Text(
                                      "恭喜你通过验证，请输入你的新密码以便完成重置密码！",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ),
                                ),
                                //新密码
                                Container(
                                  margin: EdgeInsets.only(top: 200.rpx),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                "请输入你的密码：",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 150.rpx,
                                                child: TextField(
                                                  obscureText: true,
                                                  controller:
                                                      state.passwordController,
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .grey,
                                                                      width: 1)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  2),
                                                          borderSide: BorderSide(
                                                              color: Colors.grey,
                                                              width: 1)),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 50.rpx,
                                                              top: 5.rpx,
                                                              bottom: 5.rpx,
                                                              right: 50.rpx),
                                                      hintText: "请输入新密码",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16)),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 100.rpx,
                                      ),
                                      Container(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                "请确认你的密码：",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 150.rpx,
                                                child: TextField(
                                                  obscureText: true,
                                                  controller:
                                                  state.repeatPasswordController,
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              2),
                                                          borderSide:
                                                          BorderSide(
                                                              color: Colors
                                                                  .grey,
                                                              width: 1)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                          borderSide: BorderSide(
                                                              color: Colors.grey,
                                                              width: 1)),
                                                      contentPadding:
                                                      EdgeInsets.only(
                                                          left: 50.rpx,
                                                          top: 5.rpx,
                                                          bottom: 5.rpx,
                                                          right: 50.rpx),
                                                      hintText: "请确认新密码",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16)),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 100.rpx),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: FractionallySizedBox(
                                          widthFactor: 1,
                                          child: InkWell(
                                            child: Container(
                                              height: 150.rpx,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
                                              child: Center(
                                                child: Text(
                                                  "下一步",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onTap: ()=>logic.toStep(4),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 100.rpx),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: FractionallySizedBox(
                                          widthFactor: 1,
                                          child: InkWell(
                                            child: Container(
                                              height: 150.rpx,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
                                              child: Center(
                                                child: Text(
                                                  "下一步",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onTap: ()=>logic.toStep(4),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      //  最后一步
                        Visibility(
                          visible: state.step.value == 4,
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  child: Center(
                                    child: SizedBox(
                                      width: 300.rpx,
                                      height: 300.rpx,
                                      child: Image.asset("wancheng.png".icon),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 100.rpx),
                                  child: Center(
                                    child: Text(
                                      "恭喜你成功重置密码！",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 100.rpx),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: FractionallySizedBox(
                                          widthFactor: 1,
                                          child: InkWell(
                                            child: Container(
                                              height: 170.rpx,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
                                              child: Center(
                                                child: Text(
                                                  "去登录",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onTap: ()=>Get.back(),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
