import 'dart:convert';
import 'dart:io';
import 'package:silentchat/controller/user/logic.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/space.dart';
import 'package:silentchat/entity/space_dynamic.dart';
import 'package:silentchat/entity/space_dynamic_comment.dart';
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
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamic/selectByUid",HttpMethods.POST.value, data,header: Request.getHeader());
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
  static insertSpace(Space space) async{
    Log.i("插入空间信息");
    var data = json.encode(space.toJson());
    APIResult apiResult = await BaseProvider.sendRequest("dynamic/add", HttpMethods.POST.value,data,header: Request.getHeader("json"));
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
  static insertSpaceInfo(SpaceInfo spaceInfo) async{
    Log.i("插入空间详情");
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
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamicLike/insertReturning", HttpMethods.POST.value,data,header: Request.getHeader("json"));
    return apiResult.data;
  }

  /*
   * @author Marinda
   * @date 2023/11/22 11:25
   * @description 插入空间动态
   */
  static insertSpaceDynamic(SpaceDynamic spaceDynamic) async{
    Log.i("插入空间动态详情");
    var data = json.encode(spaceDynamic.toJson());
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamic/add", HttpMethods.POST.value,data,header: Request.getHeader("json"));
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
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamic/selectContactDynamicListByUid", HttpMethods.POST.value,data,header: Request.getHeader());
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
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamicLike/selectDynamicLikeByDid", HttpMethods.POST.value,data,header: Request.getHeader());
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


  /*
   * @author Marinda
   * @date 2023/9/1 14:27
   * @description 删除点赞
   */
  static deleteDynamicLike(SpaceDynamicLike spaceDynamicLike) async{
    Log.i("删除空间动态点赞详情");
    var data = {
      "dynamicId": spaceDynamicLike.dynamicId ?? -1,
      "uid": spaceDynamicLike.uid ?? -1
    };
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamicLike/delete", HttpMethods.POST.value,data,header: Request.getHeader());
    return apiResult.data;
  }


  /*
   * @author Marinda
   * @date 2023/11/20 11:36
   * @description 插入空间动态评论
   */
   static insertSpaceDynamicComment(SpaceDynamicComment entity) async{
     Log.i("插入空间动态评论！");
    var response = await BaseProvider.sendRequest("spaceDynamicComment/insertReturning", HttpMethods.POST.value, entity.toJson(),header: Request.getHeader("json"));
    if(response.data == null) return null;
    return response.data;
  }


  /*
   * @author Marinda
   * @date 2023/11/20 14:14
   * @description 根据动态id获取相关评论信息列表
   */
  static selectDynamicCommentListByDynamicId(int dynamicId) async{
    Log.i("根据动态id获取相关评论信息列表");
    var response = await BaseProvider.sendRequest("spaceDynamicComment/selectListByDynamicId", HttpMethods.POST.value, {"dynamic_id": dynamicId},header: Request.getHeader());
    var data = response.data;
    if(data == null) return <SpaceDynamicComment>[];
    if(data is List){
      return data.map((e) => SpaceDynamicComment.fromJson(e)).toList();
    }
  }


  /*
   * @author Marinda
   * @date 2023/11/20 14:17
   * @description 修改空间动态评论信息
   */
  static updateDynamicComment(SpaceDynamicComment element) async{
    Log.i("修改空间动态评论信息");
    var response = await BaseProvider.sendRequest("spaceDynamicComment/update", HttpMethods.POST.value, element.toJson(),header: Request.getHeader());
    var data = response.data;
    if(data == null) return -1;
    return data;
  }


  /*
   * @author Marinda
   * @date 2023/11/20 16:13
   * @description 删除空间动态评论信息
   */
  static deleteDynamicCommentById(int id) async{
    Log.i("删除空间动态评论信息");
    var response = await BaseProvider.sendRequest("spaceDynamicComment/remove", HttpMethods.POST.value,{"id": id},header: Request.getHeader());
    var data = response.data;
    if(data == null) return -1;
    return data;
  }
}