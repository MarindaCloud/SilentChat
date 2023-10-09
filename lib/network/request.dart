import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/enum/HttpContetType.dart';
import 'package:silentchat/network/interceptors/custom_Interceptor.dart';
import 'package:silentchat/util/log.dart';
class Request{
  static String token = "";
  static String host = "175.24.177.189";
  static int port = 8080;
  static final dioOption = BaseOptions();
  static final Dio _dio = Dio(dioOption);
  static bool expireToken = false;


  /*
   * @author Marinda
   * @date 2023/10/9 15:43
   * @description 获取标头
   */
  static Map<String,dynamic> getHeader([String type = "normal"]){
    String value = "";
    switch(type.toUpperCase()){
      case "JSON":
        value = HttpContentType.JSON.type;
        break;
      case "NORMAL":
        value = HttpContentType.FORMDATA.type;
        break;
      case "MULTIPART":
        value = HttpContentType.MULTIPART.type;
        break;
    }
    Map<String,dynamic> header = {
      "Content-Type": value
    };
    return header;
  }


  /*
   * @author Marinda
   * @date 2023/6/8 15:53
   * @description 内置请求
   */
  static dynamic requestStream(String path,{String method = "",dynamic data,Map<String,dynamic>? header}) async{
    Response? responseData;
    var dio = Dio();
    dio.options.responseType = ResponseType.stream;
    try{
      String url = path;
      Log.i("请求地址：${url},参数：${data},请求头：${header}");
      responseData = await dio.request(url,data: data,options: Options(method: method,headers: header));
      if(responseData.statusCode != 200){
        Log.i("服务器请求错误，状态码：${responseData.statusCode},结果：${responseData.data}");
        return Future.error("服务器请求错误，状态码：${responseData.statusCode},结果：${responseData.data}");
      }else{
        return responseData.data;
        // Log.i("响应结果：${responseData.data}");
      }
    }catch(e){
      Log.e(e);
      return Future.error("解析响应数据异常！");
    }
  }

  /*
   * @author Marinda
   * @date 2023/6/8 15:53
   * @description 内置请求
   */
  static dynamic _request(String path,{String method = "",dynamic data,Map<String,dynamic>? header}) async{
    try{
      String url = "http://${host}:${port}/${path}";
      if(_dio.interceptors.isEmpty){
        _dio.interceptors.add(CustomInterceptor(_dio));
      }
      Log.i("请求地址：${url},参数：${data},请求头：${header}");
      var responseData = await _dio.request(url,data: data,options: Options(method: method,headers: header));
      if(responseData.statusCode != 200){
        Log.i("服务器请求错误，状态码：${responseData.statusCode},结果：${responseData.data}");
        return Future.error("服务器请求错误，状态码：${responseData.statusCode},结果：${responseData.data}");
      }else{
        return responseData.data;
        // Log.i("响应结果：${responseData.data}");
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
  static Future<T> sendPost<T>(String url,{required dynamic data,required Map<String,dynamic> header}) async{
    header["token"] = Request.token;
    return await _request(url,method: "post",data: data,header: header);
  }

  /*
   * @author Marinda
   * @date 2023/6/8 15:25
   * @description 发送Get请求
   */
  static Future<T> sendGet<T>(String url,{dynamic data,Map<String,dynamic>? header}) async{
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
  static APIResult toAPIResult(response) {
    String responseJson = json.encode(response);
    Map<String,dynamic> responseData = json.decode(responseJson);
    APIResult apiResult = APIResult.fromJson(responseData);
    return apiResult;
  }


}