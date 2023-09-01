import 'dart:convert';
import 'dart:io';

import 'package:silentchat/controller/user/logic.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/space.dart';
import 'package:silentchat/entity/space_dynamic.dart';
import 'package:silentchat/entity/space_dynamic_info.dart';
import 'package:silentchat/entity/space_dynamic_like.dart';
import 'package:silentchat/enum/HttpContetType.dart';
import 'package:silentchat/enum/http_method.dart';
import 'package:silentchat/network/api/base_provider.dart';
import 'package:silentchat/network/request.dart';
import 'package:silentchat/util/log.dart';
/**
 * @author Marinda
 * @date 2023/8/21 14:16
 * @description 空间API
 */
class SpaceAPI {
  static final userLogic = Get.find<UserLogic>();
  static final userState = Get.find<UserLogic>().state;

  
  /*
   * @author Marinda
   * @date 2023/8/21 14:28
   * @description 查询当前用户 / 指定用户uid的动态信息
   */
  static selectSpaceDynamicByUid([int uid = -1]) async{
    int targetId = uid != -1 ? uid : userState.uid.value;
    var data = {
      "uid": targetId
    };
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamic/selectByUid",HttpMethods.POST.value, data,header: Request.header);
    var value = apiResult.data;
    if(value is List){
      List valueList = value.map((e) => SpaceDynamic.fromJson(e)).toList();
      return valueList;
    }
    return [];
  }


  /*
   * @author Marinda
   * @date 2023/8/21 14:31
   * @description 插入Space
   */
  static insertDynamic(Space space) async{
    Log.i("插入空间信息");
    var data = json.encode(space.toJson());
    var header = {
      "Content-Type": HttpContentType.JSON.type
    };
    APIResult apiResult = await BaseProvider.sendRequest("dynamic/add", HttpMethods.POST.value,data,header: header);
    var value = apiResult.data;
    if(value == null){
      return null;
    }
    Space spaceResult = Space.fromJson(apiResult.data);
    return spaceResult;
  }

  /*
   * @author Marinda
   * @date 2023/8/21 14:45
   * @description 插入空间详情
   */
  static insertDynamicInfo(SpaceInfo spaceInfo) async{
    Log.i("插入空间动态详情");
    var data = json.encode(spaceInfo.toJson());
    var header = {
      "Content-Type": HttpContentType.JSON.type
    };
    APIResult apiResult = await BaseProvider.sendRequest("dynamicInfo/add", HttpMethods.POST.value,data,header: header);
    var value = apiResult.data;
    if(value == null){
      return null;
    }
    SpaceInfo spaceInfoResult = SpaceInfo.fromJson(apiResult.data);
    return spaceInfoResult;
  }

  /*
   * @author Marinda
   * @date 2023/8/21 14:55
   * @description 插入空间动态点赞信息
   */
  static insertDynamicLike(SpaceDynamicLike spaceDynamicLike) async{
    Log.i("插入空间动态点赞详情");
    var data = json.encode(spaceDynamicLike.toJson());
    var header = {
      "Content-Type": HttpContentType.JSON.type
    };
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamicLike/insertReturning", HttpMethods.POST.value,data,header: header);
    return apiResult.data;
  }

  /*
   * @author Marinda
   * @date 2023/9/1 10:34
   * @description 查询当前用户所有好友动态列表
   */
  static selectContactDynamicList() async{
    int uid = userState.uid.value;
    var data = {
      "uid": uid
    };
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamic/selectContactDynamicListByUid", HttpMethods.POST.value,data,header: Request.header);
    if(apiResult.data == null){
      return null;
    }
    //api结果为list
    if(apiResult.data is List){
      var list = apiResult.data as List;
      List<SpaceDynamic> spaceDynamic = list.map((e) => SpaceDynamic.fromJson(e)).toList();
      return spaceDynamic;
    }
  }

  /*
   * @author Marinda
   * @date 2023/9/1 10:55
   * @description 查询指定动态点赞详情列表
   */
  static selectDynamicLikeByDid(int dynamicId) async{
    Log.i("查询动态：${dynamicId}的点赞详情列表");
    var data = {
      "dynamic_id": dynamicId
    };
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamicLike/selectDynamicLikeByDid", HttpMethods.POST.value,data,header: Request.header);
    if(apiResult.data == null){
      return null;
    }
    //api结果为list
    if(apiResult.data is List){
      var list = apiResult.data as List;
      List<SpaceDynamicLike> spaceDynamicLikeList = list.map((e) => SpaceDynamicLike.fromJson(e)).toList();
      return spaceDynamicLikeList;
    }
    
  }
}