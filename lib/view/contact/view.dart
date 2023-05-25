import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'logic.dart';

/**
 * @author Marinda
 * @date 2023/5/25 16:10
 * @description 联系人
 */
class ContactPage extends StatelessWidget {
  ContactPage({Key? key}) : super(key: key);

  final logic = Get.find<ContactLogic>();
  final state = Get
      .find<ContactLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        child: SafeArea(
          child: Column(
            children: [
              //头部
              Container(
                padding: EdgeInsets.only(
                    right: 40.rpx, top: 10.rpx, left: 40.rpx),
                height: 200.rpx,
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "联系人",
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 10.rpx,
                                fontSize: 18
                            ),
                          ),
                        )
                    ),
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
                        state.showAddFriends.value = !state.showAddFriends
                            .value;
                      },
                    )
                  ],
                ),
              ),
              //  搜索框
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(
                      right: 40.rpx, top: 20.rpx, left: 40.rpx),
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
                        child: Text("搜索", style: TextStyle(
                            color: Colors.white, fontSize: 14)),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  print('搜索');
                },
              ),
              //新朋友 & 群通知
              Container(
                margin: EdgeInsets.only(
                    right: 60.rpx, top: 50.rpx, left: 40.rpx),
                child: Column(
                  children: [
                    Container(
                      height: 250.rpx,
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(
                              color: Colors.grey, width: 1))
                      ),
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: Text(
                                  "新朋友", style: TextStyle(fontSize: 16),)
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              width: 60.rpx,
                              height: 60.rpx,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: Image
                                          .asset("assets/logo.jpg")
                                          .image,
                                      fit: BoxFit.fill
                                  )
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          print("123");
                        },
                      ),
                    ),
                    Container(
                      height: 250.rpx,
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: Text(
                                  "群通知", style: TextStyle(fontSize: 16),)
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              width: 60.rpx,
                              height: 60.rpx,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: Image
                                          .asset("assets/logo.jpg")
                                          .image,
                                      fit: BoxFit.fill
                                  )
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          print("123");
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 100.rpx, right: 100.rpx),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 30.rpx),
                      decoration: state.page.value == 0 ? BoxDecoration(
                          border: Border(bottom: BorderSide(
                              width: 1, color: Colors.blue))
                      ) : BoxDecoration(),
                      child: Text("好友",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 100.rpx),
                    Container(
                      padding: EdgeInsets.only(bottom: 30.rpx),
                      decoration: state.page.value == 1 ? BoxDecoration(
                          border: Border(bottom: BorderSide(
                              width: 1, color: Colors.blue))
                      ) : BoxDecoration(),
                      child: Text("群聊",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              //分组详情
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 30.rpx),
                  child: PageView(
                    onPageChanged: (page) {
                      state.page.value = page;
                    },
                    children: [
                      //好友
                      Container(
                        child: Stack(
                          children: [
                            Container(
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(left: 50.rpx, right: 100.rpx),
                                  child: Column(
                                    children: logic.buildFriends(),
                                  ),
                                ),
                              ),
                            ),
                          //  字母排序
                            Positioned(
                              right: 10.rpx,
                                top: 300.rpx,
                                child: Container(
                                  child: Column(
                                    children: state.letterList.map((e){
                                      return InkWell(
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 10.rpx),
                                          child: Text(e,style: TextStyle(
                                              color: state.chooseLetter.value == e ? Colors.blue : Colors.grey,
                                            fontSize: 12
                                          )),
                                        ),
                                        onTap: (){
                                          state.chooseLetter.value = e;
                                        },
                                      );
                                    }).toList(),
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                      //  群聊
                      Container(
                        color: Colors.blue,
                      ),
                    ],
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
