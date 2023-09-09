import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/util/overlay_manager.dart';
import 'state.dart';

class AppendLogic extends GetxController with GetTickerProviderStateMixin{
  final AppendState state = AppendState();
  final userLogic = Get.find<UserLogic>();
  final userState = Get.find<UserLogic>().state;
  final systemLogic = Get.find<SystemLogic>();
  final systemState = Get.find<SystemLogic>().state;

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
        //如果查找到的用户id是自己
        if(user.number == userState.user.value.number){
          BotToast.showText(text: "查询SCID不能为自己！");
          return;
        }
        state.searchResultList.value = [user];
        state.searchFlag.value = true;
        break;
    }
  }

  /*
   * @author Marinda
   * @date 2023/6/26 16:25
   * @description 显示添加消息的请求组件
   */
  toAppendMessage() async{
    dynamic target;
    if(state.type == 1){
      target = state.searchResultList.first;
    }
    Get.toNamed(AppPage.appendMessage,arguments: {"type": state.type,"element": target});
  }

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
                        child: Text("${state.type == 1 ? element.signature ?? "这个很懒，什么都没留下" : element
                            .description}", style: TextStyle(
                            color: Colors.grey, fontSize: 16)),
                      )
                    ],
                  ),
                ),
              ),
              // Expanded(child: SizedBox()),
              //加好友按钮
              Container(
                width: 300.rpx,
                height: 200.rpx,
                color: Colors.blue,
                child: TextButton(
                  onPressed: (){
                    Log.i("加好友！");
                    toAppendMessage();
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
