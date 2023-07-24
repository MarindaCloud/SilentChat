import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/chat_info.dart';
import 'package:silentchat/entity/group_user_info.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/enum/HttpContetType.dart';
import 'package:silentchat/enum/http_method.dart';
import 'package:silentchat/network/api/base_provider.dart';
import 'package:silentchat/network/api/group_info_api.dart';
import 'package:silentchat/network/request.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:silentchat/util/log.dart';
/**
 * @author Marinda
 * @date 2023/6/9 15:30
 * @description 消息API
 */
class MessageAPI {
  static final userLogic = Get.find<UserLogic>();
  static final userState = Get.find<UserLogic>().state;

  /*
   * @author Marinda
   * @date 2023/6/9 15:30
   * @description 插入Message
   */
  static insertMessage(Message message) async{
    Log.i("发起添加消息请求！");
    dynamic data = json.encode(message.toJson());
    Map<String,dynamic> header = {
      "Content-Type": HttpContentType.JSON.type
    };
    return BaseProvider.sendRequest("message/insertReturning", HttpMethods.POST.value, data,header: header);
  }


  /*
   * @author Marinda
   * @date 2023/6/9 15:30
   * @description 插入Message
   */
  static selectById(int id) async{
    var data = {
      "id": id
    };
    Log.i("查询id: ${id}的消息信息");
    return BaseProvider.sendRequest("user/selectById", HttpMethods.POST.value, data,header: Request.header);
  }

  /*
   * @author Marinda
   * @date 2023/6/12 13:48
   * @description 通过消息id获取消息详情
   */
  static selectMessageById(int id) async{
    var data = {
      "id": id
    };
    APIResult result = await BaseProvider.sendRequest("message/selectById", HttpMethods.POST.value, data,header: Request.header);
    if(result.data == null){
      return APIResult.fail("没有这条消息信息！");
    }
    Message message = Message.fromJson(result.data);
    return message;
  }

  /*
   * @author Marinda
   * @date 2023/6/12 11:35
   * @description 根据uid获取聊天消息详情数据
   */
  static selectUserChatInfo() async{
    int uid = userState.uid.value;
    Log.i("查询id: ${uid}的消息详情列表");
    var data = {
      "uid" : uid
    };
    APIResult result = await BaseProvider.sendRequest("chatInfo/selectUserChatInfo", HttpMethods.POST.value, data,header: Request.header);
    if(result.data == null){
      return null;
    }
    List list = result.data;
    print('list: ${list}');
    List<ChatInfo> chatInfoList = list.map((e) => ChatInfo.fromJson(e)).toList();
    return chatInfoList;
  }


  /*
   * @author Marinda
   * @date 2023/6/12 11:35
   * @description 根据uid获取聊天消息详情数据
   */
  static selectGroupChatInfos() async{
    List<GroupUserInfo> groupUserInfoList = await GroupInfoAPI.selectByUid(userState.user.value.id ?? -1);
    List<ChatInfo> groupChatInfo = [];
    for(var groupElement in groupUserInfoList){
      int groupId = groupElement.gid ?? -1;
      ChatInfo element = await selectGroupChatInfo(groupId);
      groupChatInfo.add(element);
    }

    if(groupChatInfo.isEmpty){
      return null;
    }
    return groupChatInfo;
  }


  /*
   * @author Marinda
   * @date 2023/6/12 11:35
   * @description 根据群聊id获取聊天消息详情数据
   */
  static selectGroupChatInfo(int groupId) async{
    var data = {
      "group_id" : groupId
    };
    Log.i("查询id: ${groupId}的消息信息");
    APIResult result = await BaseProvider.sendRequest("chatInfo/selectGroupChatInfo", HttpMethods.POST.value, data,header: Request.header);
    if(result.data == null){
      return null;
    }
    List list = result.data;
    List<ChatInfo> chatInfoList = list.map((e) => ChatInfo.fromJson(e)).toList();
    return chatInfoList;
  }

  /*
   * @author Marinda
   * @date 2023/6/12 11:35
   * @description 根据群聊id获取聊天消息详情数据
   */
  static insertChatInfo(ChatInfo chatInfo) async{
    Log.i("插入聊天详情数据！");
    dynamic header = {
      "Content-Type": HttpContentType.JSON.type
    };
    APIResult result = await BaseProvider.sendRequest("chatInfo/add", HttpMethods.POST.value, chatInfo.toJson(),header: header);
    if(result.data == null){return false;}
    return true;
  }

}