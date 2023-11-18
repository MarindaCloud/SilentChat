import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'logic.dart';

/**
 * @author Marinda
 * @date 2023/11/16 17:27
 * @description 编辑用户信息Page
 */
class EditUserInfoPage extends StatelessWidget {
  EditUserInfoPage({Key? key}) : super(key: key);

  final logic = Get.find<EditUserInfoLogic>();
  final state = Get
      .find<EditUserInfoLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Container(
          color: Color.fromRGBO(242, 242, 242, 1),
          child: SafeArea(
            child: Column(
              children: [
                //header
                Container(
                  height: 200.rpx,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.translate(
                          offset: Offset(100.rpx, 0),
                          child: IconButtonComponent("back", Colors.grey)
                      ),
                      Container(
                        child: Text(
                          "编辑资料",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                          ),
                        ),
                      ),
                      Container()
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 100.rpx,
                          left: 50.rpx,
                          right: 50.rpx),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          logic.buildEditInfo(
                              "用户名", state.userNameController,true),
                          logic.buildSexWidget(),
                          logic.buildEditInfo("邮箱", state.emailController),
                          logic.buildEditInfo("地址", state.locationController),
                          logic.buildEditInfo("签名", state.signatureController),
                          logic.buildBirthDay()
                        ],
                      ),
                    ),
                  ),
                ),
                //提交修改
                Container(
                  padding: EdgeInsets.only(left: 100.rpx,right: 100.rpx),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.only(right: 100.rpx),
                            decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(width: 1,color: Colors.grey))
                            ),
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: Text(
                                  "修改信息",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onTap: ()=>logic.updateUserInfo(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 100.rpx),
                          child: InkWell(
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: Text(
                                  "重置信息",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                            onTap: ()=>logic.reset(),
                          ),
                        ),
                      ),
                    ],
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
