import 'dart:convert';
import 'dart:io';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/util/log.dart';
import '../request.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart' as d;
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
    var response = await Request.sendPost("user/login", data: data, header: Request.getHeader());
    Log.i("response: ${response}");
    APIResult apiResult = Request.toAPIResult(response);
    if(apiResult.data != null){
      User user = User.fromJson(apiResult.data["user"]);
      String token = apiResult.data["token"];
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
    Log.i("发起用户注册：用户名：${user.username}");
    Map<String,dynamic> data = {
      "username": user.username,
      "password": user.password,
      "email": user.email
    };
    var response = await Request.sendPost("user/register", data: data, header: Request.getHeader());
    return Request.toAPIResult(response);
  }

  /*
   * @author Marinda
   * @date 2023/6/12 10:50
   * @description 根据id查询用户信息
   */
  static selectByUid(int id) async{
    Log.i("查询id: ${id}的用户信息");
    Map<String,dynamic> data = {
      "id": id,
    };
    var response = await Request.sendPost("user/selectById", data: data, header: Request.getHeader());
    APIResult apiResult =  Request.toAPIResult(response);
    if(apiResult.data == null){
      return APIResult.fail("失败");
    }
    User user = User.fromJson(apiResult.data);
    return user;
  }

  /*
   * @author Marinda
   * @date 2023/6/8 16:36
   * @description 登录接口
   */
  static selectUserByNumber(int number) async{
    Log.i("查询默讯号：${number}的用户！");
    var data = {
      "number": number
    };
    var response = await Request.sendPost("user/selectByNumber", data: data, header: Request.getHeader());
    APIResult apiResult =  Request.toAPIResult(response);
    if(apiResult.data == null) return null;
    User user = User.fromJson(apiResult.data);
    return user;
  }


  /*
   * @author Marinda
   * @date 2023/7/7 16:53
   * @description 上传头像
   */
  static uploadPortrait(File file,User user) async{
    Log.i("${user.username}上传头像");
    d.MultipartFile multipartFile = await d.MultipartFile.fromFile(file.path);
    d.FormData formData = d.FormData.fromMap({
      "file": multipartFile,
      "uid": user.id??-1
    });
    var response = await Request.sendPost("user/portrait", data: formData, header: {});
    APIResult apiResult = Request.toAPIResult(response);
    if(apiResult.data == null){
      return "";
    }
    return apiResult.data;
  }

  /*
   * @author Marinda
   * @date 2023/7/7 18:05
   * @description 修改用户信息
   */
  static updateUser(User user) async{
    Log.i("修改${user.id}用户的信息");
    var response = await Request.sendPost("user/update", data: json.encode(user.toJson()), header: Request.getHeader("json"));
    APIResult apiResult = Request.toAPIResult(response);
    if(apiResult.data == 0 || apiResult.data == -1){
      return false;
    }
    return true;
  }


  /*
   * @author Marinda
   * @date 2023/11/22 16:08
   * @description 修改密码
   */
  static forgotPwd(User user,String pwd) async{
    Log.i("修改${user.username}用户的密码");
    Map<String,dynamic> data = {
      "number": user.number.toString(),
      "password": pwd
    };
    var response = await Request.sendPost("user/forgotPwd", data: data, header: Request.getHeader());
    APIResult apiResult = Request.toAPIResult(response);
    if(apiResult.data == 0 || apiResult.data == -1){
      return false;
    }
    return true;
  }
}