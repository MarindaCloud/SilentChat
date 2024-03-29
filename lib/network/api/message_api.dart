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
    return BaseProvider.sendRequest("message/insertReturning", HttpMethods.POST.value, data,header: Request.getHeader("json"));
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
    return BaseProvider.sendRequest("user/selectById", HttpMethods.POST.value, data,header: Request.getHeader());
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
    APIResult result = await BaseProvider.sendRequest("message/selectById", HttpMethods.POST.value, data,header: Request.getHeader());
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
    APIResult result = await BaseProvider.sendRequest("chatInfo/selectUserChatInfo", HttpMethods.POST.value, data,header: Request.getHeader());
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
   * @description 根据uid获取聊天消息详情数据
   */
  static selectGroupChatInfos() async{
    List<GroupUserInfo> groupUserInfoList = await GroupInfoAPI.selectByUid(userState.user.value.id ?? -1);
    List<ChatInfo> groupChatInfo = [];
    for(var groupElement in groupUserInfoList){
      int groupId = groupElement.gid ?? -1;
      List<ChatInfo> element = await selectGroupChatInfo(groupId);
      groupChatInfo.addAll(element);
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
      "groupId" : groupId
    };
    Log.i("查询id: ${groupId}的消息信息");
    APIResult result = await BaseProvider.sendRequest("chatInfo/selectGroupChatInfo", HttpMethods.POST.value, data,header: Request.getHeader());
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
    APIResult result = await BaseProvider.sendRequest("chatInfo/add", HttpMethods.POST.value, chatInfo.toJson(),header: Request.getHeader("json"));
    if(result.data == null){return false;}
    return true;
  }


  /*
   * @author Marinda
   * @date 2023/9/8 16:44
   * @description 查询两名用户最新聊天消息
   */
  static selectNewMessage(int sendId,int receiverId,[int type = 1]) async{
    Log.i("查询${sendId}和${receiverId}最新聊天消息");
    var data = {
      "sendId": sendId,
      "receiverId": receiverId,
      "type": type
    };
    APIResult result = await BaseProvider.sendRequest("message/getNewMessage", HttpMethods.POST.value,data ,header: Request.getHeader());
    if(result.data == null){return false;}
    Message message = Message.fromJson(result.data);
    return message;
  }


  /*
   * @author Marinda
   * @date 2023/9/11 16:37
   * @description 查询消息列表
   */
  static selectUserMessageList(int sendId,int receiverId) async{
    Log.i("查询${sendId},${receiverId}消息列表");
    var data = {
      "sendId": sendId,
      "receiverId": receiverId
    };
    APIResult result = await BaseProvider.sendRequest("message/selectUserMessageList", HttpMethods.POST.value,data ,header: Request.getHeader());
    if(result.data == null){return [];}
    if(result.data is List){
      List list = result.data;
      List<Message> messageList = list.map((e) => Message.fromJson(e)).toList();
      return messageList;
    }
    return <Message>[];
  }

  /*
   * @author Marinda
   * @date 2023/9/12 11:03
   * @description 查询群组消息列表
   */
  static selectGroupMessageList(int groupId) async{
    Log.i("查询群组id：${groupId}的消息列表");
    var data = {
      "groupId": groupId
    };
    APIResult result = await BaseProvider.sendRequest("message/selectGroupMessageList", HttpMethods.POST.value,data ,header: Request.getHeader());
    if(result.data == null){return false;}
    if(result.data is List){
      List list = result.data;
      List<Message> messageList = list.map((e) => Message.fromJson(e)).toList();
      return messageList;
    }
    return [];
  }

  /*
   * @author Marinda
   * @date 2023/9/15 15:41
   * @description 获取两个用户的所有聊天详情
   */
  static selectChatInfoByInUser(int sendId,int receiverId) async{
    var data = {
      "sendId" : sendId,
      "receiverId": receiverId
    };
    Log.i("获取: ${sendId},${receiverId}聊天的详情列表");
    APIResult result = await BaseProvider.sendRequest("chatInfo/selectChatInfoByInUser", HttpMethods.POST.value, data,header: Request.getHeader());
    if(result.data == null){
      return null;
    }
    List list = result.data;
    List<ChatInfo> chatInfoList = list.map((e) => ChatInfo.fromJson(e)).toList();
    return chatInfoList;
  }


  /*
   * @author Marinda
   * @date 2023/9/15 15:44
   * @description 删除聊天详情
   */
  static removeChatInfo(int id) async{
    var data = {
      "id": id
    };
    Log.i("删除${id}的聊天详情");
    APIResult result = await BaseProvider.sendRequest("chatInfo/remove", HttpMethods.POST.value, data,header: Request.getHeader());
    if(result.data == null){
      return null;
    }
    return result.data;
  }

  /*
   * @author Marinda
   * @date 2023/9/15 16:21
   * @description 移除消息id
   */
  static removeMessage(int id) async{
    var data = {
      "id": id
    };
    Log.i("删除${id}的消息记录");
    APIResult result = await BaseProvider.sendRequest("message/remove", HttpMethods.POST.value, data,header: Request.getHeader());
    if(result.data == null){
      return null;
    }
    return result.data;
  }
}