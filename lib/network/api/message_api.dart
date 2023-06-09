import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/enum/HttpContetType.dart';
import 'package:silentchat/enum/http_method.dart';
import 'package:silentchat/network/api/base_provider.dart';
import 'package:silentchat/network/request.dart';
import 'dart:convert';

import 'package:silentchat/util/log.dart';
/**
 * @author Marinda
 * @date 2023/6/9 15:30
 * @description 消息API
 */
class MessageApi {


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
    return BaseProvider.sendRequest("message/add", HttpMethods.POST.value, data,header: header);
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
    return BaseProvider.sendRequest("message/add", HttpMethods.POST.value, data);
  }

}