import 'dart:convert';

import "package:dio/dio.dart";
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/util/log.dart';
import '../request.dart';
/**
 * @author Marinda
 * @date 2023/6/8 16:28
 * @description 用户请求接口
 */
class UserAPI {


  /*
   * @author Marinda
   * @date 2023/6/8 16:36
   * @description 登录接口
   */
  static login(String username,String password) async{
    Log.i("发起用户登录：用户名：${username}");
    Map<String,dynamic> data = {
      "username": username,
      "password": password
    };
    var response = await Request.sendPost("user/login", data: data, header: Request.header);
    Log.i("response: ${response}");
    APIResult apiResult = await Request.toAPIResult(response);
    if(apiResult.data != null){
      String token = apiResult.data;
      Request.token = token;
    }
    Log.i("RequestToken: ${Request.token}");
    return apiResult;
  }

  /*
   * @author Marinda
   * @date 2023/6/8 16:36
   * @description 登录接口
   */
  static register(User user) async{
    Log.i("发起用户注册：用户名：${user.userName}");
    Map<String,dynamic> data = {
      "username": user.userName,
      "password": user.password,
      "phone": user.phone
    };
    return await Request.sendPost("user/login", data: data, header: Request.header);
  }

}