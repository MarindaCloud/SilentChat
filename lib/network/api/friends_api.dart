import 'dart:convert';

import "package:dio/dio.dart";
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/friend.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/enum/HttpContetType.dart';
import 'package:silentchat/enum/http_method.dart';
import 'package:silentchat/network/api/base_provider.dart';
import 'package:silentchat/util/log.dart';
import '../request.dart';
import 'package:get/get.dart';
/**
 * @author Marinda
 * @date 2023/6/9 18:02
 * @description 朋友API
 */
class FriendsAPI {
  static final userLogic = Get.find<UserLogic>();
  static final userState = Get.find<UserLogic>().state;

  /*
   * @author Marinda
   * @date 2023/6/9 18:07
   * @description 插入朋友信息
   */
  static insertFriends(Friend friend) async{
    Log.i("发起添加消息请求！");
    dynamic data = json.encode(friend.toJson());
    Map<String,dynamic> header = {
      "Content-Type": HttpContentType.JSON.type
    };
    return BaseProvider.sendRequest("friends/add", HttpMethods.POST.value, data,header: header);
  }

  /*
   * @author Marinda
   * @date 2023/6/9 18:07
   * @description 通过id获取朋友详情
   */
  static selectById(int id) async{
    var data = {
      "id": id
    };
    Log.i("查询id: ${id}的消息信息");
    return BaseProvider.sendRequest("friends/selectById", HttpMethods.POST.value, data,header: Request.header);
  }

  /*
   * @author Marinda
   * @date 2023/6/9 18:07
   * @description 通过uid获取朋友详情列表
   */
  static selectByUid() async{
    int uid = userState.uid.value;
    var data = {
      "uid": uid
    };
    Log.i("查询id: ${uid}的朋友信息列表");
    APIResult apiResult = await BaseProvider.sendRequest("friends/selectByUid", HttpMethods.POST.value, data,header: Request.header);
    List list = apiResult.data;
    List<Friend> friendList = list.map((e){return Friend.fromJson(e);}).toList();
    return friendList;
  }
}