import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:silentchat/util/log.dart';
import 'state.dart';

class AppendLogic extends GetxController with GetTickerProviderStateMixin{
  final AppendState state = AppendState();
  final SystemLogic logic = Get.find<SystemLogic>();
  final SystemState systemState = Get
      .find<SystemLogic>()
      .state;

  @override
  void onInit() {
    state.animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    state.animation = Tween<Offset>(begin: Offset(0,-1),end: Offset(0,0)).animate(state.animationController!);
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/6/21 13:43
   * @description 查询方法
   */
  search() async{
    state.animationController!.reset();
    state.animationController!.forward();
    //type -> 1=联系人 2=群聊
    int type = 0;
    int number = 0;
    String text = state.accountTextController!.text;
    try{
      number = int.parse(text).toInt();
      if(text.length == 8){
        type = 2;
      }else{
        type = 1;
      }
    }catch(e){
      BotToast.showText(text: "请输入正确的默讯号");
      Log.e(e);
    }
      await searchResultByType(type, number);
  }

  /*
   * @author Marinda
   * @date 2023/6/21 13:55
   * @description 根据type返回查询结果
   */
  searchResultByType(int type,int number) async{
    switch(type){
      case 1:
        //联系人
        var user = await UserAPI.selectUserByNumber(number);
        if(user == null){
          state.searchFlag.value = false;
          BotToast.showText(text: "用户不存在！");
          return;
        }
        state.searchResultList.value = [user];
        state.searchFlag.value = true;
        break;
    }
  }

  /*
   * @author Marinda
   * @date 2023/6/19 17:51
   * @description
   */
  // List<Widget> buildWidget() {
  //   List<Widget> list = [];
  //   List<dynamic> valueEntityList = [];
  //   switch (state.type) {
  //     case 1:
  //       for (int i = 0; i < 4; i++) {
  //         User user = User(id: (i + 1),
  //             username: "用户${(i + 1)}",
  //             phone: "13376549876");
  //         valueEntityList.add(user);
  //       }
  //       break;
  //     case 2:
  //       for (int i = 0; i < 4; i++) {
  //         Group group = Group(id: (i + 1),
  //             name: "群聊${i + 1}",
  //             portrait: "assets/user/portait.png",
  //             description: "这是群简介",
  //             personMax: 100,
  //             adminMax: 10,
  //             rank: i);
  //         valueEntityList.add(group);
  //       }
  //       break;
  //   }
  //
  //   //遍历所有目标
  //   for (var element in valueEntityList) {
  //     var widget = Container(
  //       margin: EdgeInsets.only(bottom: 100.rpx),
  //       child: Row(
  //           children: [
  //             //头像信息
  //             Container(
  //                 height: 200.rpx,
  //                 width: 200.rpx,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(1000),
  //                   image: DecorationImage(
  //                     image: Image.asset(
  //                         state.type == 2 ? element.portrait : "assets/user/portait.png").image,
  //                     fit: BoxFit.fill
  //                   )
  //                 )
  //             ),
  //             SizedBox(width: 60.rpx),
  //             //用户信息详情
  //             Expanded(
  //               child: Container(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     //名称
  //                     Container(
  //                       alignment: Alignment.topLeft,
  //                       child: Text(
  //                         state.type == 1 ? element.username : element.name,
  //                         style: TextStyle(
  //                             fontSize: 15, overflow: TextOverflow.ellipsis,color: Colors.green),),
  //                     ),
  //                     if(state.type == 2)
  //                       Container(
  //                         alignment: Alignment.topLeft,
  //                         child: Text.rich(TextSpan(
  //                             children: [
  //                               TextSpan(text: "群人数：", style: TextStyle(
  //                                   color: Colors.black, fontSize: 14)),
  //                               TextSpan(text: "1/${element.personMax}",
  //                                   style: TextStyle(color: Colors.red,
  //                                       fontSize: 14,
  //                                       overflow: TextOverflow.ellipsis)),
  //                             ]
  //                         )),
  //                       ),
  //                     //群聊则是简介/手机号
  //                     Container(
  //                       alignment: Alignment.topLeft,
  //                       child: Text("${state.type == 1 ? element.phone : element
  //                           .description}", style: TextStyle(
  //                           color: Colors.grey, fontSize: 16)),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(child: SizedBox()),
  //             //加好友按钮
  //             Container(
  //               // width: 350.rpx,
  //               height: 200.rpx,
  //               color: Colors.blue,
  //               child: TextButton(
  //                 onPressed: (){
  //                   print('test');
  //             },
  //                 child: Text(state.type == 1 ? "加好友" : "加入群聊",style: TextStyle(color: Colors.white,fontSize: 14),),
  //               ),
  //             )
  //           ]
  //       ),
  //     );
  //     list.add(widget);
  //   }
  //   return list;
  // }

  /*
   * @author Marinda
   * @date 2023/6/19 17:51
   * @description
   */
  List<Widget> buildWidget() {
    List<Widget> list = [];
    //遍历所有目标
    for (var element in state.searchResultList) {
      var widget = Container(
        child: Row(
            children: [
              //头像信息
              InkWell(
                child: Container(
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
                onTap: (){
                  Get.toNamed(AppPage.userInfo,arguments: element.id);
                },
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
                          state.type == 1 ? element.username : element.name,
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
