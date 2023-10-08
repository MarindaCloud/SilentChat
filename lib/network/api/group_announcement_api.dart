import 'dart:convert';
import 'dart:io';

import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/group_announcement.dart';
import 'package:silentchat/enum/HttpContetType.dart';
import 'package:silentchat/enum/http_method.dart';
import 'package:silentchat/network/api/base_provider.dart';
import 'package:silentchat/network/request.dart';
import 'package:silentchat/util/log.dart';
import 'package:get/get.dart';
/**
 * @author Marinda
 * @date 2023/10/8 18:05
 * @description 群公告API
 */
class GroupAnnouncementAPI{
  static final userLogic = Get.find<UserLogic>();
  static final userState = Get.find<UserLogic>().state;

  /*
   * @author Marinda
   * @date 2023/10/8 18:06
   * @description 插入
   */
  static insert(GroupAnnouncement groupAnnouncement) async{
    Log.i("组：${groupAnnouncement.gid},添加群组公告：${groupAnnouncement.content}");
    var data = json.encode(groupAnnouncement.toJson());
    Map<String,dynamic> header = {
      "Content-Type": HttpContentType.JSON.type
    };
    APIResult apiResult =  await BaseProvider.sendRequest("groupAnnouncement/insertReturnId", HttpMethods.POST.value, data,header: header);
    if(apiResult.data == null){
      return null;
    }
    return apiResult.data;
  }

  /*
   * @author Marinda
   * @date 2023/10/8 18:12
   * @description 通过群组id获取公告列表详情
   */
  static selectByGid(int groupId) async{
    Log.i("查询群组：${groupId}的所有公告列表");
    var data = {
      "gid": groupId
    };
    APIResult apiResult =  await BaseProvider.sendRequest("groupAnnouncement/selectByGid", HttpMethods.POST.value, data,header: Request.header);
    List list = apiResult.data;
    if(list.isEmpty){
      return [];
    }
    return list.map((e) => GroupAnnouncement.fromJson(e)).toList();
  }

  /*
   * @author Marinda
   * @date 2023/10/8 18:21
   * @description 删除目标id
   */
  static removeById(int id) async{
    Log.i("删除id为：${id}的公告");
    var data = {
      "id": id
    };
    APIResult apiResult =  await BaseProvider.sendRequest("groupAnnouncement/remove", HttpMethods.POST.value, data,header: Request.header);
    if(apiResult.data == null){
      return null;
    }
    return apiResult.data;
  }

  /*
   * @author Marinda
   * @date 2023/10/8 18:22
   * @description 修改公告
   */
  static update(GroupAnnouncement element) async{
    Log.i("修改群id为：${element.gid}的公告");
    var data = json.encode(element.toJson());
    Map<String,dynamic> header = {
      "Content-Type": HttpContentType.JSON.type
    };
    APIResult apiResult =  await BaseProvider.sendRequest("groupAnnouncement/update", HttpMethods.POST.value, data,header: header);
    if(apiResult.data == null){
      return null;
    }
    return apiResult.data;
  }
}