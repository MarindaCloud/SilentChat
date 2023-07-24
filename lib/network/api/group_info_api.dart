import 'dart:convert';

import "package:dio/dio.dart";
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/friend.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/group_user_info.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/enum/HttpContetType.dart';
import 'package:silentchat/enum/http_method.dart';
import 'package:silentchat/network/api/base_provider.dart';
import 'package:silentchat/util/log.dart';
import '../request.dart';
import 'package:get/get.dart';
/*
 * @author Marinda
 * @date 2023/7/24 14:57
 * @description 群组信息API (用来获取群聊用户信息)
 */
class GroupInfoAPI {
  static final userLogic = Get.find<UserLogic>();
  static final userState = Get.find<UserLogic>().state;

  /*
   * @author Marinda
   * @date 2023/6/9 18:07
   * @description 插入群组Group
   */
  static insertGroupInfo(GroupUserInfo groupUserInfo) async{
    Log.i("插入群组详情数据");
    dynamic data = json.encode(groupUserInfo.toJson());
    var response = await BaseProvider.sendRequest("groupUserInfo/add", HttpMethods.POST.value, data,header: Request.getHeader(type: "json"));
    APIResult apiResult = Request.toAPIResult(response);
    if(apiResult.data == null){
      return false;
    }
    return apiResult.data;
  }

  /*
   * @author Marinda
   * @date 2023/7/24 14:58
   * @description 查询指定id的群组用户信息详情
   */
  static selectById(int id) async{
    var data = {
      "id": id
    };
    Log.i("查询id: ${id}的群组详情数据");
    return BaseProvider.sendRequest("groupUserInfo/selectById", HttpMethods.POST.value, data,header: Request.header);
  }


  /*
   * @author Marinda
   * @date 2023/7/24 15:00
   * @description 根据uid获取加入的群组详情数据
   */
  static selectByUid(int uid) async{
    var data = {
      "uid": uid
    };
    Log.i("查询id: ${uid}的群组详情数据");
    return BaseProvider.sendRequest("groupUserInfo/selectById", HttpMethods.POST.value, data,header: Request.header);
  }
}