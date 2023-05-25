import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'logic.dart';

class MessagePage extends StatelessWidget {
  MessagePage({Key? key}) : super(key: key);

  final logic = Get.find<MessageLogic>();
  final state = Get
      .find<MessageLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Stack(
            children: [
              //头部基础内容
              Container(
                child: Column(
                  children: [
                    //头部
                    Container(
                      padding: EdgeInsets.only(right: 40.rpx, top: 10.rpx,left: 40.rpx),
                      height: 200.rpx,
                      color: Colors.grey,
                      child: Row(
                        children: [
                          //头像
                          Container(
                            width: 150.rpx,
                            height: 150.rpx,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10000),
                                image: DecorationImage(
                                    image: Image
                                        .asset("assets/logo.jpg")
                                        .image,
                                    fit: BoxFit.fill
                                )
                            ),
                          ),
                          //  昵称 & 登录信息
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 30.rpx),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                        child: Text("云", style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                          overflow: TextOverflow.ellipsis,)
                                    ),
                                  ),
                                  //状态 & 登录设备
                                  Container(
                                    margin: EdgeInsets.only(top: 5.rpx),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50.rpx,
                                          height: 50.rpx,
                                          margin: EdgeInsets.only(
                                              right: 10.rpx),
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius
                                                  .circular(10000)
                                          ),
                                        ),
                                        Container(
                                          child: Text("IPhoneXR在线",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          //工具栏
                          InkWell(
                            child: Container(
                              width: 100.rpx,
                              height: 100.rpx,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: Image
                                          .asset("assets/logo.jpg")
                                          .image,
                                      fit: BoxFit.fill
                                  )
                              ),
                            ),
                            onTap: () {
                              state.showTools.value = !state.showTools.value;
                            },
                          )
                        ],
                      ),
                    ),
                  //  搜索框
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(right: 40.rpx, top: 20.rpx,left: 40.rpx),
                        height: 150.rpx,
                        color: Colors.blueGrey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //搜索
                            SizedBox(
                              width: 80.rpx,
                              height: 80.rpx,
                              child: Image.asset("assets/logo.jpg")
                            ),
                            SizedBox(width: 20.rpx),
                            //搜索
                            Container(
                              child: Text("搜索",style: TextStyle(color: Colors.white,fontSize: 14)),
                            )
                          ],
                        ),
                      ),
                      onTap: (){
                        print('搜索');
                      },
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                        child: Column(
                          children: logic.buildRecordList(),
                        ),
                    ))
                  ],
                ),
              ),
              Visibility(
                visible: state.showTools.value,
                child: Positioned(
                  right: 0,
                  top: 200.rpx,
                  child: Container(
                    padding: EdgeInsets.only(left: 50.rpx,right: 30.rpx,top: 50.rpx,bottom: 50.rpx),
                    width: 600.rpx,
                    color: Colors.blue,
                    child: Column(
                      children: logic.buildToolsList(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
