import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/friends_verify.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/network/api/verify_api.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';

import 'state.dart';

/**
 * @author Marinda
 * @date 2023/7/4 11:34
 * @description  验证的相关控制器处理
 */
class VerifyLogic extends GetxController {
  final VerifyState state = VerifyState();
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;

  @override
  void onInit() {
    var args = Get.arguments;
    state.value = args;
    initVerifyInfo();
    // TODO: implement onInit
    super.onInit();
  }


  /*
   * @author Marinda
   * @date 2023/7/4 18:43
   * @description 构建朋友信息列表
   */
  List<Widget> buildFriendsVerifyList(){
    List<Widget> widgetList = [];
    for(var verify in state.verifyList){
      //朋友验证对象
      if(verify is FriendsVerify){
         Widget widget = Container(
           padding:
           EdgeInsets.symmetric(horizontal: 20, vertical: 0),
           height: 300.rpx,
           child: Row(
             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               //头像
               Container(
                 margin: EdgeInsets.only(right: 30.rpx),
                 width: 250.rpx,
                 height: 250.rpx,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10000),
                     image: DecorationImage(
                         image: Image.asset(
                             "assets/user/portait.png")
                             .image,
                         fit: BoxFit.cover)),
               ),
               //信息
               Container(
                 padding: EdgeInsets.only(top: 10),
                 margin: EdgeInsets.only(left: 10),
                 child: Column(
                   children: [
                     Text("用户名",
                         style: TextStyle(
                             color: Colors.black, fontSize: 16)),
                     SizedBox(height: 50.rpx),
                     Container(
                         child: Text("个性签名",
                             style: TextStyle(
                                 color: Colors.black, fontSize: 16)))
                   ],
                 ),
               ),
               Expanded(child: SizedBox()),
               Container(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     // Expanded(child: SizedBox()),
                     Container(
                       margin: EdgeInsets.only(left: 50.rpx),
                       child: TextButton(
                         child: Text("同意",
                             style:
                             TextStyle(color: Colors.white)),
                         onPressed: () {},
                         style: ButtonStyle(
                             backgroundColor:
                             MaterialStateProperty.all(
                                 Colors.blue)),
                       ),
                     ),
                     // Expanded(child: SizedBox()),
                     Container(
                       margin: EdgeInsets.only(left: 50.rpx),
                       child: TextButton(
                         child: Text("拒绝",
                             style:
                             TextStyle(color: Colors.white)),
                         onPressed: () {},
                         style: ButtonStyle(
                             backgroundColor:
                             MaterialStateProperty.all(
                                 Colors.red)),
                       ),
                     ),
                   ],
                 ),
               )
             ],
           ),
         );
         widgetList.add(widget);
      }
    }
    return widgetList;
  }


  /*
   * @author Marinda
   * @date 2023/7/4 16:46
   * @description 初始化验证信息
   */
  initVerifyInfo() async{
    List<FriendsVerify> resultList = [];
    var value = state.value;
    int uid = userState.uid.value;
    int type = value["type"];
    switch(type){
      //用户
      case 1:
        List<FriendsVerify> friendsVerifyList = await VerifyAPI.selectByUidOrTidList(uid);
        resultList = friendsVerifyList;
        Log.i("朋友验证列表：${friendsVerifyList.map((e) => e.toJson()).toList()}");
        break;
    }
    state.verifyList.value = resultList;
  }

}
