import 'dart:convert';
import 'dart:io';
import 'package:silentchat/controller/user/logic.dart';
import 'package:get/get.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/space.dart';
import 'package:silentchat/entity/space_dynamic.dart';
import 'package:silentchat/entity/space_dynamic_comment.dart';
import 'package:silentchat/entity/space_dynamic_info.dart';
import 'package:silentchat/entity/space_dynamic_info_view.dart';
import 'package:silentchat/entity/space_dynamic_like.dart';
import 'package:silentchat/entity/space_user_info.dart';
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
   * @date 2023/11/23 15:06
   * @description 通过动态id获取动态信息
   */
  static selectDynamicById(int dynamicId) async{
    var data = {
      "id": dynamicId
    };
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamic/selectById",HttpMethods.POST.value, data,header: Request.getHeader());
    var value = apiResult.data;
    if(value == null){
      return null;
    }
    SpaceDynamic spaceDynamic = SpaceDynamic.fromJson(value);
    return spaceDynamic;
  }

  /*
   * @author Marinda
   * @date 2023/11/23 14:56
   * @description 通过空间id获取动态列表详情
   */
  static selectDynamicInfoBySid(int sid) async{
    var data = {
      "space_id": sid
    };
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamicInfo/selectBySid",HttpMethods.POST.value, data,header: Request.getHeader());
    var value = apiResult.data;
    if(value == null){
      return <SpaceDynamicInfo>[];
    }
    List<SpaceDynamicInfo> dynamicInfoList = [];
    if(value is List){
      dynamicInfoList = value.map((e) => SpaceDynamicInfo.fromJson(e)).toList();
    }
    return dynamicInfoList;
  }

  /*
   * @author Marinda
   * @date 2023/11/23 14:44
   * @description 通过用户id获取控件动态详情
   */
  static selectUserSpaceByUid([int uid = -1]) async{
    int targetId = uid != -1 ? uid : userState.uid.value;
    var data = {
      "uid": targetId
    };
    APIResult apiResult = await BaseProvider.sendRequest("spaceUserInfo/selectByUid",HttpMethods.POST.value, data,header: Request.getHeader());
    var value = apiResult.data;
    if(value == null){
      return null;
    }
    var element = SpaceUserInfo.fromJson(value);
    return element;
  }

  /*
   * @author Marinda
   * @date 2023/11/28 15:36
   * @description 通过空间动态id 删除空间动态id
   */
  static deleteSpaceDynamicById(int dynamicId) async{
    Log.i("删除空间动态: ${dynamicId}");
    var data = {
      "id": dynamicId,
    };
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamic/remove", HttpMethods.POST.value, data,header: Request.getHeader());
    var value = apiResult.data;
    if(value == null){
      return -1;
    }
    return value;
  }

  /*
   * @author Marinda
   * @date 2023/11/28 14:37
   * @description 修改用户动态信息
   */
  static updateSpaceDynamic(SpaceDynamic spaceDynamic) async{
    Log.i("修改动态信息: ${spaceDynamic.id}");
    String data = json.encode(spaceDynamic);
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamic/updateSpaceDynamic", HttpMethods.POST.value,data,header: Request.getHeader("json"));
    var value = apiResult.data;
    if(value == null){
      return -1;
    }
    return value;
  }

  /*
   * @author Marinda
   * @date 2023/8/21 14:31
   * @description 插入Space
   */
  static insertSpace(Space space) async{
    Log.i("插入空间信息");
    var data = json.encode(space.toJson());
    APIResult apiResult = await BaseProvider.sendRequest("space/insertReturning", HttpMethods.POST.value,data,header: Request.getHeader("json"));
    var value = apiResult.data;
    if(value == null){
      return null;
    }
    return apiResult.data;
  }

  /*
   * @author Marinda
   * @date 2023/8/21 14:45
   * @description 插入空间动态详情
   */
  static insertSpaceDynamicInfo(SpaceDynamicInfo spaceInfo) async{
    Log.i("插入空间动态详情");
    var data = json.encode(spaceInfo.toJson());
    var header = {
      "Content-Type": HttpContentType.JSON.type
    };
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamicInfo/add", HttpMethods.POST.value,data,header: header);
    var value = apiResult.data;
    return value;
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
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamic/insertReturning", HttpMethods.POST.value,data,header: Request.getHeader("json"));
    return apiResult.data;
  }

  /*
   * @author Marinda
   * @date 2023/11/23 14:39
   * @description 插入空间用户详情
   */
  static insertSpaceUserInfoDynamic(SpaceUserInfo spaceUserInfo) async{
    Log.i("插入空间用户详情");
    var data = json.encode(spaceUserInfo.toJson());
    APIResult apiResult = await BaseProvider.sendRequest("spaceUserInfo/add", HttpMethods.POST.value,data,header: Request.getHeader("json"));
    return apiResult.data;
  }

  /*
   * @author Marinda
   * @date 2023/11/23 15:02
   * @description 查询当前空间动态用户
   */
  static selectDynamicListByUid() async{
    int uid = userState.uid.value;
    var data = {
      "uid": uid
    };
    APIResult apiResult = await BaseProvider.sendRequest("spaceDynamic/selectByUid", HttpMethods.POST.value,data,header: Request.getHeader());
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