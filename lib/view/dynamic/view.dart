import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'logic.dart';

/**
 * @author Marinda
 * @date 2023/5/25 17:28
 * @description 动态处理
 */
class DynamicPage extends StatelessWidget {
  DynamicPage({Key? key}) : super(key: key);

  final logic = Get.find<DynamicLogic>();
  final state = Get.find<DynamicLogic>().state;

  @override
  Widget build(BuildContext context) {
      return Container(
        child: Column(
          children: [
          //  头像信息
            Container(
              width: double.infinity,
              height: 800.rpx,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image
                          .asset("assets/user/portait.png")
                          .image,
                      fit: BoxFit.fill
                  )
              ),
            ),
            Expanded(
                child: Container(
                  // padding: EdgeInsets.only(left: 40.rpx,right: 40.rpx,top: 30.rpx,bottom: 30.rpx),
                  child: Column(
                    children: [
                      //好友动态
                      Container(
                        height: 300.rpx,
                        child: Container(
                          // color: Colors.green,
                          margin: EdgeInsets.only(bottom: 40.rpx),
                          padding: EdgeInsets.only(left: 60.rpx,right:60.rpx,top: 30.rpx,bottom: 0.rpx),
                          child: InkWell(
                            child: Row(
                              children: [
                                //图标
                                Container(
                                  margin: EdgeInsets.only(right: 40.rpx),
                                  child: SizedBox(
                                    width: 80.rpx,
                                    height: 80.rpx,
                                    child: Image.asset("assets/icon/dynamic.png",color: Colors.orange,),
                                  ),
                                ),
                                Container(
                                  child: Text("好友动态",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),),
                                ),
                                Expanded(child: SizedBox()),
                                //好友头像+新发表情况
                                Container(
                                  child: Row(
                                    children: [
                                      //多少人发表 & 头像信息
                                      Container(
                                        margin: EdgeInsets.only(right: 30.rpx),
                                        child: Text("21人新发表",style: TextStyle(color: Colors.grey,fontSize: 14),),
                                      ),
                                      //头像信息
                                      Container(
                                        child: Container(
                                          width: 100.rpx,
                                          height: 100.rpx,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(1000),
                                            image: DecorationImage(
                                              image: Image.asset("assets/user/portait.png").image,
                                              fit: BoxFit.fill
                                            ),
                                          ),
                                          
                                        ),
                                      ),
                                      //头像信息
                                      Container(
                                        child: Container(
                                          width: 100.rpx,
                                          height: 100.rpx,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(1000),
                                              image: DecorationImage(
                                                  image: Image.asset("assets/user/portait.png").image,
                                                  fit: BoxFit.fill
                                              )
                                          ),

                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 30.rpx),
                                //图标
                                Container(
                                  margin: EdgeInsets.only(right: 20.rpx),
                                  child: SizedBox(
                                    width: 80.rpx,
                                    height: 80.rpx,
                                    child: Image.asset("assets/icon/qianwang.png"),
                                  ),
                                ),
                              ],
                            ),
                            onTap: (){
                              print("测试");
                            },
                          ),
                        ),
                      ),
                      //其他图标功能
                      Container(
                        margin: EdgeInsets.only(bottom: 40.rpx),
                        // color: Colors.orange,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 60.rpx,right:60.rpx,top: 30.rpx,bottom: 0.rpx),
                              margin: EdgeInsets.only(bottom: 40.rpx),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    //图标
                                    Container(
                                      margin: EdgeInsets.only(right: 40.rpx),
                                      child: SizedBox(
                                        width: 80.rpx,
                                        height: 80.rpx,
                                        child: Image.asset("assets/icon/youxi.png"),
                                      ),
                                    ),
                                    Container(
                                      child: Text("游戏中心",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),),
                                    ),
                                    Expanded(child: SizedBox()),
                                    //图标
                                    Container(
                                      margin: EdgeInsets.only(right: 20.rpx),
                                      child: SizedBox(
                                        width: 80.rpx,
                                        height: 80.rpx,
                                        child: Image.asset("assets/icon/qianwang.png"),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: (){
                                  print("游戏中心");
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 60.rpx,right:60.rpx,top: 30.rpx,bottom: 0.rpx),
                              margin: EdgeInsets.only(bottom: 40.rpx),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    //图标
                                    Container(
                                      margin: EdgeInsets.only(right: 40.rpx),
                                      child: SizedBox(
                                        width: 80.rpx,
                                        height: 80.rpx,
                                        child: Image.asset("assets/icon/fujin.png",color: Colors.green,),
                                      ),
                                    ),
                                    Container(
                                      child: Text("附近",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),),
                                    ),
                                    Expanded(child: SizedBox()),
                                    //图标
                                    Container(
                                      margin: EdgeInsets.only(right: 20.rpx),
                                      child: SizedBox(
                                        width: 80.rpx,
                                        height: 80.rpx,
                                        child: Image.asset("assets/icon/qianwang.png"),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: (){
                                  print("附近");
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      //其他图标功能
                      Container(
                        margin: EdgeInsets.only(bottom: 40.rpx),
                        // color: Colors.orange,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 60.rpx,right:60.rpx,top: 30.rpx,bottom: 0.rpx),
                              margin: EdgeInsets.only(bottom: 40.rpx),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    //图标
                                    Container(
                                      margin: EdgeInsets.only(right: 40.rpx),
                                      child: SizedBox(
                                        width: 80.rpx,
                                        height: 80.rpx,
                                        child: Image.asset("assets/icon/yuedu.png"),
                                      ),
                                    ),
                                    Container(
                                      child: Text("动漫",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),),
                                    ),
                                    Expanded(child: SizedBox()),
                                    //图标
                                    Container(
                                      margin: EdgeInsets.only(right: 20.rpx),
                                      child: SizedBox(
                                        width: 80.rpx,
                                        height: 80.rpx,
                                        child: Image.asset("assets/icon/qianwang.png"),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: (){
                                  print("动漫");
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 60.rpx,right:60.rpx,top: 30.rpx,bottom: 0.rpx),
                              margin: EdgeInsets.only(bottom: 40.rpx),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    //图标
                                    Container(
                                      margin: EdgeInsets.only(right: 40.rpx),
                                      child: SizedBox(
                                        width: 80.rpx,
                                        height: 80.rpx,
                                        child: Image.asset("assets/icon/shujiyuedu.png"),

                                      ),
                                    ),
                                    Container(
                                      child: Text("阅读",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),),
                                    ),
                                    Expanded(child: SizedBox()),
                                    //图标
                                    Container(
                                      margin: EdgeInsets.only(right: 20.rpx),
                                      child: SizedBox(
                                        width: 80.rpx,
                                        height: 80.rpx,
                                        child: Image.asset("assets/icon/qianwang.png"),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: (){
                                  print("阅读");
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 60.rpx,right:60.rpx,top: 30.rpx,bottom: 0.rpx),
                              margin: EdgeInsets.only(bottom: 40.rpx),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    //图标
                                    Container(
                                      margin: EdgeInsets.only(right: 40.rpx),
                                      child: SizedBox(
                                        width: 80.rpx,
                                        height: 80.rpx,
                                        child: Image.asset("assets/icon/gouwuche.png",color: Colors.red,),
                                      ),
                                    ),
                                    Container(
                                      child: Text("购物",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),),
                                    ),
                                    Expanded(child: SizedBox()),
                                    //图标
                                    Container(
                                      margin: EdgeInsets.only(right: 20.rpx),
                                      child: SizedBox(
                                        width: 80.rpx,
                                        height: 80.rpx,
                                        child: Image.asset("assets/icon/qianwang.png"),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: (){
                                  print("购物");
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 60.rpx,right:60.rpx,top: 30.rpx,bottom: 0.rpx),
                              margin: EdgeInsets.only(bottom: 40.rpx),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    //图标
                                    Container(
                                      margin: EdgeInsets.only(right: 40.rpx),
                                      child: SizedBox(
                                        width: 80.rpx,
                                        height: 80.rpx,
                                        child: Image.asset("assets/icon/yinle.png"),
                                      ),
                                    ),
                                    Container(
                                      child: Text("音乐",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),),
                                    ),
                                    Expanded(child: SizedBox()),
                                    //图标
                                    Container(
                                      margin: EdgeInsets.only(right: 20.rpx),
                                      child: SizedBox(
                                        width: 80.rpx,
                                        height: 80.rpx,
                                        child: Image.asset("assets/icon/qianwang.png"),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: (){
                                  print("音乐");
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 60.rpx,right:60.rpx,top: 30.rpx,bottom: 0.rpx),
                              margin: EdgeInsets.only(bottom: 40.rpx),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    //图标
                                    Container(
                                      margin: EdgeInsets.only(right: 40.rpx),
                                      child: SizedBox(
                                        width: 80.rpx,
                                        height: 80.rpx,
                                        child: Image.asset("assets/icon/ziyuanxhdpi.png"),                                      ),
                                    ),
                                    Container(
                                      child: Text("更多",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),),
                                    ),
                                    Expanded(child: SizedBox()),
                                    //图标
                                    Container(
                                      margin: EdgeInsets.only(right: 20.rpx),
                                      child: SizedBox(
                                        width: 80.rpx,
                                        height: 80.rpx,
                                        child: Image.asset("assets/icon/qianwang.png"),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: (){
                                  print("更多");
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      );
  }
}
