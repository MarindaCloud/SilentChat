import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/network/interceptors/custom_Interceptor.dart';
import 'package:silentchat/util/log.dart';
class Request{
  static String token = "";
  static String host = "localhost";
  static int port = 8080;
  static final dioOption = BaseOptions(connectTimeout: 5000,receiveTimeout: 3000);
  static final Dio _dio = Dio(dioOption);
  static bool expireToken = false;

  /*
   * @author Marinda
   * @date 2023/6/8 15:53
   * @description 内置请求
   */
  static Future<T> _request<T>(String path,{String method = "",Map<String,dynamic>? data,Map<String,dynamic>? header}) async{
    try{
      String url = "http://${host}:${port}/${path}";
      if(_dio.interceptors.isEmpty){
        _dio.interceptors.add(CustomInterceptor(_dio));
      }
      Log.i("请求地址：${url},参数：${data},请求头：${header}");
      Response responseData = await _dio.request(url,data: data,options: Options(method: method,headers: header));
      if(responseData.statusCode != 200){
        Log.i("服务器请求错误，状态码：${responseData.statusCode},结果：${responseData.data}");
        return Future.error("服务器请求错误，状态码：${responseData.statusCode},结果：${responseData.data}");
      }else{
        Log.i("响应结果：${responseData.data}");
        return responseData.data;
      }
    }catch(e){
      Log.e(e);
      return Future.error("解析响应数据异常！");
    }
  }
  
  /*
   * @author Marinda
   * @date 2023/6/8 15:25
   * @description 发送Post请求
   */
  static Future<T> sendPost<T>(String url,{required Map<String,dynamic> data,required Map<String,dynamic> header}) async{
    header["token"] = Request.token;
    return await _request(url,method: "post",data: data,header: header);
  }

  /*
   * @author Marinda
   * @date 2023/6/8 15:25
   * @description 发送Get请求
   */
  static Future<T> sendGet<T>(String url,{Map<String,dynamic>? data,Map<String,dynamic>? header}) async{
    Map<String,dynamic> defaultHeader = {
      "token": token
    };
    Map<String,dynamic> headers = header ?? defaultHeader;
    return await _request(url,method: "get",data: data,header: headers);
  }

  /*
   * @author Marinda
   * @date 2023/6/8 16:51
   * @description response转成APIResult
   */
  static Future<APIResult> toAPIResult(response) async{
    String responseJson = json.encode(response);
    Map<String,dynamic> responseData = json.decode(responseJson);
    APIResult apiResult = APIResult.fromJson(responseData);
    return apiResult;
  }

}