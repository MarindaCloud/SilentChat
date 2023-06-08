import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:silentchat/network/request.dart';
class CustomInterceptor extends Interceptor{
  final Dio _dio;

  CustomInterceptor(this._dio);

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    return super.onRequest(options, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async{
    return super.onError(err, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async{
    bool expireToken = validExpireToken(response);
    Request.expireToken = expireToken;
    return super.onResponse(response, handler);
  }

  /*
   * @author Marinda
   * @date 2023/6/8 15:35
   * @description 检查是否过期的Token
   */
  bool validExpireToken(Response response){
    if(Request.token == ""){
      return true;
    }
    var responseMap = response.data is String? jsonDecode(response.data) :response.data;
    int code = responseMap["code"];
    if(code == 6401){return true;}
    return false;
  }

}