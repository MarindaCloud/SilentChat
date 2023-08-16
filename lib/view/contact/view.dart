import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/view/contact/state.dart';
import 'package:silentchat/view/index/logic.dart';

import 'logic.dart';

/**
 * @author Marinda
 * @date 2023/5/25 16:10
 * @description 联系人
 */
class ContactPage extends StatelessWidget {
  ContactPage({Key? key}) : logic = Get.put(ContactLogic()),state = Get.find<ContactLogic>().state, super(key: key);

  final ContactLogic logic;
  final ContactState state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: Color.fromRGBO(84,176,247,1),
        child: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              //头部
              Container(
                padding: EdgeInsets.only(
                    right: 40.rpx, top: 10.rpx, left: 40.rpx),
                height: 200.rpx,
                // color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //头像
                    InkWell(
                      child: Container(
                        width: 150.rpx,
                        height: 150.rpx,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10000),
                            image: DecorationImage(
                                image: Image
                                    .network("${logic.userState.user.value.portrait}")
                                    .image,
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                      onTap: (){
                        Get.find<IndexLogic>().state.showUserInfo.value = true;
                      },
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
                      child: SizedBox(
                        width: 100.rpx,
                        height: 100.rpx,
                        child: Image.asset("assets/icon/tianjiahaoyou.png",color: Colors.white,),
                      ),
                      onTap: () {
                        //跳转至添加好友
                        Get.toNamed(AppPage.append);
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      //  搜索框
                      Container(
                        color: Color.fromRGBO(242,242,242,1),
                        child: InkWell(
                          child: Container(
                            margin: EdgeInsets.only(right: 60.rpx, top: 50.rpx,left: 60.rpx,bottom: 100.rpx),
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
                                    child: Image.asset("assets/icon/sousuo.png")
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
                                      width: 80.rpx,
                                      height: 80.rpx,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: Image
                                                  .asset("assets/icon/qianwang.png")
                                                  .image,
                                              fit: BoxFit.fill
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  print("123");
                                  logic.toFriendsVerify();
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
                                      width: 80.rpx,
                                      height: 80.rpx,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: Image
                                                  .asset("assets/icon/qianwang.png")
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
                      //群组详情
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
                              //群组
                              Container(
                                child: Stack(
                                  children: [
                                    Container(
                                      child: SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 50.rpx, right: 100.rpx),
                                          child: Column(
                                            children: logic.buildGroups(),
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
      );
    });
  }
}
