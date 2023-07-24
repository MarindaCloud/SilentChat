import 'dart:convert';

import "package:dio/dio.dart";
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/friend.dart';
import 'package:silentchat/entity/group.dart';
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
class GroupAPI {
  static final userLogic = Get.find<UserLogic>();
  static final userState = Get.find<UserLogic>().state;

  /*
   * @author Marinda
   * @date 2023/6/9 18:07
   * @description 插入群组Group
   */
  static insertGroup(Group group) async{
    Log.i("插入群组数据：${group.name}");
    dynamic data = json.encode(group.toJson());
    var response = await BaseProvider.sendRequest("group/insert", HttpMethods.POST.value, data,header: Request.getHeader(type: "json"));
    APIResult apiResult = Request.toAPIResult(response);
    if(apiResult.data == null){
      return false;
    }
    return apiResult.data;
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
    Log.i("查询id: ${id}的群组Id");
    return BaseProvider.sendRequest("group/selectById", HttpMethods.POST.value, data,header: Request.header);
  }

  
}