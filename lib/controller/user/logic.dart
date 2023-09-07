import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/logic/cache_image_handle.dart';
import 'package:silentchat/entity/friend.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/group_user_info.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/friends_api.dart';
import 'package:silentchat/network/api/group_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/util/date_time_util.dart';
import 'package:silentchat/util/log.dart';

import 'state.dart';

class UserLogic extends GetxController {
  final UserState state = UserState();

  /*
   * @author Marinda
   * @date 2023/6/25 10:29
   * @description 1男2女
   */
  String getSex(){
    int sex = state.user.value.sex ?? -1;
    return sex == 1 ? "男" : "女";
  }

  /*
   * @author Marinda
   * @date 2023/9/7 17:18
   * @description 构建头像
   */
  buildPortraitWidget([int type = 1,String targetPortrait = ""]){
    String portrait = "";
    if(targetPortrait != ""){
      portrait = targetPortrait;
    }else{
     portrait = state.user.value.portrait ?? "";
    }
    return CacheImageHandle.buildImageWidget(portrait, type);
  }

  /*
   * @author Marinda
   * @date 2023/6/25 10:30
   * @description 获取出生日期
   */
  String getDate(){
    DateTime? dateTime = state.user.value.birthday;
    if(dateTime == null){
      return "";
    }
    print('当前日期：${dateTime}');
    return DateTimeUtil.formatDateTime(dateTime,format: DateTimeUtil.md);
  }

  /*
   * @author Marinda
   * @date 2023/6/25 10:35
   * @description 获取年龄
   */
  int getAge(){
    int birthDayYear = state.user.value.birthday?.year ?? 0;
    return (DateTime.now().year - birthDayYear);
  }

  /*
   * @author Marinda
   * @date 2023/6/25 10:44
   * @description 获取位置
   */
  String getLocation(){
    return state.user.value.location.toString();
  }


  String getProvince(){
    String location = getLocation();
    String subString = location.substring(0,2);
    return subString ;
  }

  String getCity(){
    String location = getLocation();
    String subString = location.substring(2);
    return subString;
  }

  /*
   * @author Marinda
   * @date 2023/6/9 18:02
   * @description 初始化朋友列表
   */
  initFriendsList() async{
    List<Friend> friendList = await FriendsAPI.selectByUid();
    List<User> userList = [];
    for(Friend friend in friendList){
      int friendId = friend?.fid ?? -1;
      User user  = await UserAPI.selectByUid(friendId);
      await CacheImageHandle.addImageCache(user.portrait ?? "");
      userList.add(user);
    }
    state.friendUserList.value = userList.toSet().toList();
    Log.i("朋友用户详情列表List: ${userList.map((e) => e.toJson()).toList()}");
  }



  /*
   * @author Marinda
   * @date 2023/8/4 15:38
   * @description 查询指定uid
   */
  selectByUid(int uid) async{
    User user = await UserAPI.selectByUid(uid);
    return user;
  }
}
