import 'dart:io';

import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/network/request.dart';
import 'package:silentchat/util/log.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
/**
 * @author Marinda
 * @date 2023/10/7 15:45
 * @description 公共API
 */
class CommonAPI {


  /*
   * @author Marinda
   * @date 2023/10/7 15:46
   * @description 上传文件
   */
  static uploadFile(File file,String dir) async{
    Log.i("上传文件${file.path}");
    d.MultipartFile multipartFile = await d.MultipartFile.fromFile(file.path);
    d.FormData formData = d.FormData.fromMap({
      "file": multipartFile,
      "dir": dir
    });
    var response = await Request.sendPost("common/upload", data: formData, header: {});
    APIResult apiResult = Request.toAPIResult(response);
    if(apiResult.data == null){
      return "";
    }
    return apiResult.data;
  }
}