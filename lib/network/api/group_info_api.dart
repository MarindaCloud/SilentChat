import 'dart:convert';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/group_user_info.dart';
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
    var response = await BaseProvider.sendRequest("groupUserInfo/add", HttpMethods.POST.value, data,header: Request.getHeader("json"));
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
    return BaseProvider.sendRequest("groupUserInfo/selectById", HttpMethods.POST.value, data,header: Request.getHeader());
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
    var response = await BaseProvider.sendRequest("groupUserInfo/selectByUid", HttpMethods.POST.value, data,header: Request.getHeader());
    APIResult apiResult = Request.toAPIResult(response);
    if(apiResult.data == null){
      return false;
    }
    List<GroupUserInfo> groupUserInfoList = [];
    if(apiResult.data is List){
      var list = apiResult.data as List;
      groupUserInfoList = list.map((e) => GroupUserInfo.fromJson(e)).toList();
    }
    return groupUserInfoList;
  }

  /*
   * @author Marinda
   * @date 2023/10/8 11:18
   * @description  查询群聊中所有群员详情
   */

  static selectByGid(int gid) async{
    Log.i("查询id: ${gid}的群组用户详情数据");
    var response = await BaseProvider.sendRequest("groupUserInfo/selectByGid", HttpMethods.POST.value, {"gid": gid},header: Request.getHeader());
    APIResult apiResult = Request.toAPIResult(response);
    if(apiResult.data == null){
      return false;
    }
    List<GroupUserInfo> groupUserInfoList = [];
    if(apiResult.data is List){
      var list = apiResult.data as List;
      groupUserInfoList = list.map((e) => GroupUserInfo.fromJson(e)).toList();
    }
    return groupUserInfoList;
  }


  static update(GroupUserInfo element) async{
    Log.i("修改id为: ${element.id ?? -1},群用户详情");
    var data = json.encode(element.toJson());
    var response = await BaseProvider.sendRequest("groupUserInfo/update", HttpMethods.POST.value, data,header: Request.getHeader("json"));
    return response.data;
  }
}