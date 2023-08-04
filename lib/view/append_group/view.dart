import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/back_navigator.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/append_group/state.dart';

import 'logic.dart';

class AppendGroupPage extends StatelessWidget {

  final AppendGroupLogic logic;
  final AppendGroupState state;


  AppendGroupPage({Key? key})
      : logic = Get.put(AppendGroupLogic()),
        state = Get
            .find<AppendGroupLogic>()
            .state,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Container(
          color: Color.fromRGBO(242, 242, 242, 1),
          child: SafeArea(
            child: Column(
              children: [
                BackNavigatorComponent(
                    "创建群聊", Get.back, Colors.black, Colors.black),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //左边是用来显示联系人
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(right: BorderSide(
                                        color: Color.fromRGBO(
                                            204, 204, 204, 1)))
                                ),
                                child: Column(
                                  children: [
                                    //头部
                                    Container(
                                      height: 100,
                                      child: Column(
                                        children: [
                                          //搜素详情
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(width: 1,
                                                        color: Color.fromRGBO(
                                                            204, 204, 204, 1)))
                                            ),
                                            child: SizedBox(
                                              height: 30,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide
                                                            .none,
                                                        borderRadius: BorderRadius
                                                            .zero
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide
                                                            .none,
                                                        borderRadius: BorderRadius
                                                            .zero
                                                    ),
                                                    hintText: "请输入你想搜索的用户名"
                                                ),
                                                maxLength: null,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14
                                                ),
                                              ),
                                            ),
                                          ),
                                          //  用户列表
                                          Expanded(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: logic
                                                      .buildContactList(),
                                                ),
                                              )
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                          ),
                          Container(
                            width: 200,
                            height: Get.height,
                            // color: Colors.red,
                            child: Column(
                              children: [
                                Container(
                                  height: 20,
                                  child: Text.rich(TextSpan(
                                          children: [
                                            TextSpan(text: "当前选择的用户",style: TextStyle(fontSize: 14,color: Colors.black)),
                                            TextSpan(text: state.chooseUserList.isNotEmpty ? "(${state.chooseUserList.length})" : "",style: TextStyle(fontSize: 16,color: Colors.red))
                                          ]),overflow: TextOverflow.ellipsis,),
                                ),
                                Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          ...logic.buildContactList(state.chooseUserList, true),
                                          Expanded(child: SizedBox()),
                                          Container(
                                            width: Get.width,
                                            margin: EdgeInsets.only(right: 20),
                                            alignment: Alignment.centerRight,
                                            child: TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(Colors.blue)
                                                ),
                                                //创建群聊
                                                onPressed: (){
                                                  logic.createGroup();
                                                },
                                                child: Text("下一步",style: TextStyle(color: Colors.white,fontSize: 14),)),
                                          )
                                        ],
                                      ),
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
