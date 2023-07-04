import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/util/log.dart';
import '../request.dart';
import 'package:get/get.dart';
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
      "phone": user.phone
    };
    return await Request.sendPost("user/register", data: data, header: Request.header);
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
    var response = await Request.sendPost("user/selectById", data: data, header: Request.header);
    APIResult apiResult = await Request.toAPIResult(response);
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
    var response = await Request.sendPost("user/selectByNumber", data: data, header: Request.header);
    APIResult apiResult = await Request.toAPIResult(response);
    if(apiResult.data == null) return null;
    User user = User.fromJson(apiResult.data);
    return user;
  }

}