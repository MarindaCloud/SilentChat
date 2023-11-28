import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/controller/system/logic.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/space_dynamic.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/space_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';

import 'state.dart';

class DynamicLogic extends GetxController {
  final DynamicState state = DynamicState();
  final systemLogic = Get.find<SystemLogic>();
  final systemState = Get.find<SystemLogic>().state;
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;

  @override
  void onInit() {
    loadContactDynamicList();
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/9/6 15:54
   * @description 构建用户动态视图
   */
  buildDynamicUserView(){
    List<Widget> list = [];
    List<int> cacheUserId = [];
    for(var dynamicId in state.dynamicUserMap.keys){
      User user = state.dynamicUserMap[dynamicId] ?? User();
      int uid = user.id ?? -1;
      String portrait = user.portrait ?? "";
      Widget widget = Container(
        child: Container(
          width: 100.rpx,
          height: 100.rpx,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            image: DecorationImage(
                image: userLogic.buildPortraitWidget(1,portrait).image,
                fit: BoxFit.fill
            ),
          ),
        ),
      );
      if(cacheUserId.contains(uid)){
        continue;
      }
      list.add(widget);
      cacheUserId.add(uid);
    }
    return list;
  }

  /*
   * @author Marinda
   * @date 2023/9/6 15:41
   * @description 加载联系人动态列表
   */
  loadContactDynamicList() async{
    Map<int,User> dynamicUserMap = {};
    //空间动态列表
    List<SpaceDynamic> spaceDynamicList = await SpaceAPI.selectContactDynamicList();
    if(spaceDynamicList.isEmpty){
      return [];
    }
    for(var element in spaceDynamicList){
      int uid = element.uid ?? -1;
      int dynamicId = element.id ?? -1;
      User user = await UserAPI.selectByUid(uid);
      if(spaceDynamicList.length >= 0 && spaceDynamicList.length <=2){
        dynamicUserMap[dynamicId] = user;
      }
      if(element.image!="" && element.image != null){
        var result = json.decode(element.image ?? "");
        if(result is List){
          for(var src in result){
            await systemLogic.loadGlobalImageCache(user,src);
          }
          Log.i("动态图片预加载开始缓存，长度为：${result.length}");
        }
      }
    }
    //长度>=2
    if(spaceDynamicList.length >=0 && spaceDynamicList.length<=2){
      for(var element in spaceDynamicList){
        int uid = element.uid ?? -1;
        int dynamicId = element.id ?? -1;
      }
    }
    state.dynamicList.value = spaceDynamicList;
    state.dynamicUserMap = dynamicUserMap;
    Log.i("好友动态列表共有：${state.dynamicList.length}");
  }

  /*
   * @author Marinda
   * @date 2023/8/17 16:22
   * @description 跳转至Space
   */
  toSpace(){
    Get.toNamed(AppPage.space);
  }
}
