import 'dart:collection';

import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/friends_verify.dart';
import 'package:silentchat/network/request.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/util/network_util.dart';

import 'base_provider.dart';
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
      var response = await Request.sendPost("friendsVerify/selectByUidOrTidList", data: args, header: Request.header);
      APIResult apiResult =  await Request.toAPIResult(response);
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
    var response = await Request.sendPost("friendsVerify/updateFriendsVerify", data: friendsVerify.toJson(), header: Request.getHeader(type: "json"));
    APIResult apiResult = await Request.toAPIResult(response);
    if(apiResult.data is int){
      int result = apiResult.data;
      if(result <0){
        return false;
      }
      return true;
    }

  }
}