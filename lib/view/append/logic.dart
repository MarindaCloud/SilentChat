import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'state.dart';

class AppendLogic extends GetxController {
  final AppendState state = AppendState();
  final SystemLogic logic = Get.find<SystemLogic>();
  final SystemState systemState = Get
      .find<SystemLogic>()
      .state;

  @override
  void onInit() {
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/6/19 17:51
   * @description
   */
  List<Widget> buildWidget() {
    List<Widget> list = [];
    List<dynamic> valueEntityList = [];
    switch (state.type) {
      case 1:
        for (int i = 0; i < 4; i++) {
          User user = User(id: (i + 1),
              userName: "用户${(i + 1)}",
              phone: "13376549876");
          valueEntityList.add(user);
        }
        break;
      case 2:
        for (int i = 0; i < 4; i++) {
          Group group = Group(id: (i + 1),
              name: "群聊${i + 1}",
              portrait: "assets/user/portait.png",
              description: "这是群简介",
              personMax: 100,
              adminMax: 10,
              rank: i);
          valueEntityList.add(group);
        }
        break;
    }

    //遍历所有目标
    for (var element in valueEntityList) {
      var widget = Container(
        margin: EdgeInsets.only(bottom: 100.rpx),
        child: Row(
            children: [
              //头像信息
              Container(
                  height: 200.rpx,
                  width: 200.rpx,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    image: DecorationImage(
                      image: Image.asset(
                          state.type == 2 ? element.portrait : "assets/user/portait.png").image,
                      fit: BoxFit.fill
                    )
                  )
              ),
              SizedBox(width: 60.rpx),
              //用户信息详情
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //名称
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          state.type == 1 ? element.userName : element.name,
                          style: TextStyle(
                              fontSize: 15, overflow: TextOverflow.ellipsis,color: Colors.green),),
                      ),
                      if(state.type == 2)
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text.rich(TextSpan(
                              children: [
                                TextSpan(text: "群人数：", style: TextStyle(
                                    color: Colors.black, fontSize: 14)),
                                TextSpan(text: "1/${element.personMax}",
                                    style: TextStyle(color: Colors.red,
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis)),
                              ]
                          )),
                        ),
                      //群聊则是简介/手机号
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("${state.type == 1 ? element.phone : element
                            .description}", style: TextStyle(
                            color: Colors.grey, fontSize: 16)),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              //加好友按钮
              Container(
                // width: 350.rpx,
                height: 200.rpx,
                color: Colors.blue,
                child: TextButton(
                  onPressed: (){
                    print('test');
              },
                  child: Text(state.type == 1 ? "加好友" : "加入群聊",style: TextStyle(color: Colors.white,fontSize: 14),),
                ),
              )
            ]
        ),
      );
      list.add(widget);
    }
    return list;
  }




}
