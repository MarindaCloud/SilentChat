import 'dart:convert';

import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/friends_verify.dart';
import 'package:silentchat/entity/group_verify.dart';
import 'package:silentchat/network/request.dart';
import 'package:silentchat/util/log.dart';
/**
 * @author Marinda
 * @date 2023/7/4 11:40
 * @description 验证消息的API
 */
class VerifyAPI {

  /*
   * @author Marinda
   * @date 2023/7/4 17:07
   * @description 根据id获取朋友相关验证数据
   */
  static selectByUidOrTidList(int id) async{
      Map<String,dynamic>  args = {
        "id": id
      };
      var response = await Request.sendPost("friendsVerify/selectByUidOrTidList", data: args, header: Request.getHeader());
      APIResult apiResult =  Request.toAPIResult(response);
      var data =  apiResult.data;
      if(data is List){
        List<FriendsVerify> friendsVerifyList = data.map((e) => FriendsVerify.fromJson(e)).toList();
        return friendsVerifyList;
      }else{
        return null;
      }
  }

  /*
   * @author Marinda
   * @date 2023/7/4 17:22
   * @description 修改朋友验证信息
   */
  static updateFriendsVerify(FriendsVerify friendsVerify) async{
    Log.i("修改朋友验证信息状态,目标id: ${friendsVerify.id}");
    var response = await Request.sendPost("friendsVerify/updateFriendsVerify", data: json.encode(friendsVerify.toJson()), header: Request.getHeader("json"));
    Log.i("response数据: ${response}");
    APIResult apiResult = Request.toAPIResult(response);
    if(apiResult.data is int){
      int result = apiResult.data;
      if(result <0){
        return false;
      }
      return true;
    }
  }

  /*
   * @author Marinda
   * @date 2023/7/6 14:36
   * @description 插入朋友验证
   */
  static insertFriendsVerify(FriendsVerify friendsVerify) async{
    Log.i("插入朋友验证消息");
    var response = await Request.sendPost("friendsVerify/add", data: json.encode(friendsVerify.toJson()), header: Request.getHeader( "json"));
    APIResult apiResult = Request.toAPIResult(response);
    if(apiResult.data == null){
      return -1;
    }
    return apiResult.data;
  }

  /*
   * @author Marinda
   * @date 2023/12/2 14:43
   * @description 插入群聊验证消息
   */
  static insertGroupVerify(GroupVerify groupVerify) async{
    Log.i("插入群聊验证消息");
    var response = await Request.sendPost("groupVerify/add", data: json.encode(groupVerify.toJson()), header: Request.getHeader("json"));
    APIResult apiResult = Request.toAPIResult(response);
    if(apiResult.data == null){
      return -1;
    }
    return apiResult.data;
  }

  /*
   * @author Marinda
   * @date 2023/12/2 14:43
   * @description 查询该群聊所有验证消息
   */
  static selectListByGid(int gid) async{
    Log.i("查询${gid}的所有群聊验证消息");
    var response = await Request.sendPost("groupVerify/selectByGid", data: {"gid": gid}, header: Request.getHeader());
    APIResult apiResult = Request.toAPIResult(response);
    List<GroupVerify> groupVerifyList = [];
    var data = apiResult.data;
    if(data is List){
      groupVerifyList = data.map((e) => GroupVerify.fromJson(e)).toList();
    }
    return groupVerifyList;
  }

  /*
   * @author Marinda
   * @date 2023/12/2 14:43
   * @description 查询该用户所有群聊验证消息
   */
  static selectListByUserId(int uid) async{
    Log.i("查询${uid}的所有群聊验证消息");
    var response = await Request.sendPost("groupVerify/selectByUid", data: {"uid": uid}, header: Request.getHeader());
    APIResult apiResult = Request.toAPIResult(response);
    List<GroupVerify> groupVerifyList = [];
    var data = apiResult.data;
    if(data is List){
      groupVerifyList = data.map((e) => GroupVerify.fromJson(e)).toList();
    }
    return groupVerifyList;
  }


  /*
   * @author Marinda
   * @date 2023/7/4 14:52
   * @description 修改群聊验证信息
   */
  static updateGroupVerify(GroupVerify groupVerify) async{
    Log.i("修改群聊验证信息状态,目标id: ${groupVerify.id}");
    var response = await Request.sendPost("groupVerify/update", data: json.encode(groupVerify.toJson()), header: Request.getHeader("json"));
    Log.i("response数据: ${response}");
    APIResult apiResult = Request.toAPIResult(response);
    if(apiResult.data is int){
      int result = apiResult.data;
      if(result <0){
        return false;
      }
      return true;
    }
  }
}