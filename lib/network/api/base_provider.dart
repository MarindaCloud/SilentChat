import 'package:silentchat/entity/api_result.dart';

import '../request.dart';

/**
 * @author Marinda
 * @date 2023/6/9 15:43
 * @description 太多重复代码，最终都是要转成APIResult的
 * 这个类用来作为请求基类，节省重复代码
 */
class BaseProvider{

  /*
   * @author Marinda
   * @date 2023/6/9 15:46
   * @description 发送请求
   */
  static Future<APIResult> sendRequest(String url,String method,dynamic data,{dynamic header}) async{
    dynamic response;
    var headers = header ?? Request.getHeader();
    switch(method){
      case "post":
        response = await Request.sendPost(url,data: data,header: headers);
        break;
     case "get":
       response = await Request.sendGet(url,data: data,header: headers);
       break;
    }
    APIResult apiResult =  Request.toAPIResult(response);
    if(apiResult.data == null) return APIResult(code: 400,data: null,msg: "失败！");
    return apiResult;
  }

}