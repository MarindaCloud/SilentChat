import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/expansion/image_path.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/index/logic.dart';

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
        color: Color.fromRGBO(84,176,247,1),
        child: SafeArea(
          top: true,
          bottom: false,
          child: Stack(
            children: [
              //头部基础内容
              Container(
                padding: EdgeInsets.only(right: 40.rpx, top: 0.rpx,left: 40.rpx,bottom: 0.rpx),
                height: 200.rpx,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //头像
                    InkWell(
                      child: Container(
                        width: 150.rpx,
                        height: 150.rpx,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10000),
                            image: DecorationImage(
                                image: Image.network(logic.userState.user.value.portrait ??"")
                                    .image,
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                      onTap: (){
                        Get.find<IndexLogic>().state.showUserInfo.value = true;
                      },
                    ),
                    //  昵称 & 登录信息
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10.rpx,left: 20.rpx),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 5,
                              left: 0,
                              child: Container(
                                width: Get.width,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 60.rpx),
                                          child: Text("${logic.userState.user.value.username}", style: TextStyle(
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
                                            child: Text("${logic.userState.deviceName}在线",
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
                            )


                          ],
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    //工具栏
                    InkWell(
                      child: SizedBox(
                        width: 100.rpx,
                        height: 100.rpx,
                        child: Image
                            .asset("jiahao_o.png".icon,color: Colors.white,)
                      ),
                      onTap: () {
                        state.showTools.value = !state.showTools.value;
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 200.rpx),
                color: Color.fromRGBO(242, 242, 242, 1),
                // color: Colors.white,
                child: Column(
                  children: [
                    //  搜索框
                    Container(
                      color: Color.fromRGBO(242,242,242,1),
                      child: InkWell(
                        child: Container(
                          margin: EdgeInsets.only(right: 60.rpx, top: 50.rpx,left: 60.rpx),
                          height: 150.rpx,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //搜索
                              SizedBox(
                                  width: 80.rpx,
                                  height: 80.rpx,
                                  child: Image.asset("sousuo.png".icon)
                              ),
                              SizedBox(width: 20.rpx),
                              //搜索
                              Container(
                                child: Text("搜索",style: TextStyle(color: Colors.grey,fontSize: 14)),
                              )
                            ],
                          ),
                        ),
                        onTap: (){
                          print('搜索');
                        },
                      ),
                    ),
                    Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 100.rpx),
                          // color: Color.fromRGBO(242,242,242,1),
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Center(
                              child: Column(
                                children: logic.buildRecordList(),
                              ),
                            ),
                          ),
                        )),
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
                    color: logic.systemState.bodyColor,
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
