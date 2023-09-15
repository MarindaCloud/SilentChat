import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/enum/http_method.dart';
import 'package:silentchat/network/api/base_provider.dart';
import 'package:silentchat/network/request.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path_provider/path_provider.dart' as path;
import 'package:silentchat/util/log.dart';
import 'package:uuid/uuid.dart';
import 'package:get_storage/get_storage.dart';


/**
 * @author Marinda
 * @date 2023/9/7 15:15
 * @description 缓存图像处理器
 */
class CacheImageHandle{
  // Key皆为URL

  //图像文件缓存
  static Map<String,File> _fileCacheImageMap = {};
  //内存缓存
  static Map<String,Uint8List> _memoryCacheImageMap = {};

  /*
   * @author Marinda
   * @date 2023/9/7 15:26
   * @description 校验这个数据是否存在于所有缓存中
   */
  static containsImageCache(String url){
    assert(url != "");
    //如果都不存在
    if(!_fileCacheImageMap.containsKey(url) && !_memoryCacheImageMap.containsKey(url)) return false;
    //存在于文件缓存中
    if(_fileCacheImageMap.containsKey(url) || _fileCacheImageMap.containsKey(url)){
      return true;
    }
    return false;
  }

  /*
   * @author Marinda
   * @date 2023/9/7 15:32
   * @description 获取图像源
   */
  static getImageValue(String url,[int type = -1]){
    if(type != -1){
      switch(type){
        case 1:
          //文件
          return _fileCacheImageMap[url];
        case 2:
          // 内存
          return _memoryCacheImageMap[url];
      }
    }else{
      if(_fileCacheImageMap.containsKey(url)){
        return _fileCacheImageMap[url];
      }else{
        return _memoryCacheImageMap[url];
      }
    }
  }

  /*
   * @author Marinda
   * @date 2023/9/9 15:23
   * @description 直接覆盖或更新目标图像缓存数据
   */
  static putImageCache(String url,dynamic element,[int type = 1]){
    switch(type){
      case 1:
        _fileCacheImageMap[url] = element;
        break;
      case 2:
        break;
    }
  }

  /*
   * @author Marinda
   * @date 2023/9/7 15:36
   * @description 添加至图像缓存
   */
  static addImageCache(String url,[int type = 1]) async{
    if(containsImageCache(url)){
      return;
    }
      Uint8List uint8list = await downloadImage(url);
      switch(type){
        //文件
        case 1:
          File file = await _createFile(uint8list);
          Log.i("文件地址：${file.path}");
          _fileCacheImageMap[url]= file;
          break;
        //内存
        case 2:
          _memoryCacheImageMap[url] = uint8list;
          break;
      }
      Log.i("图片文件缓存长度：${_fileCacheImageMap.length}");
      Log.i("内存文件缓存长度：${_memoryCacheImageMap.length}");

  }
  
  /*
   * @author Marinda
   * @date 2023/9/7 17:08
   * @description 移除缓存
   */
  static removeImageCache(String url,int type) async{
    assert(containsImageCache(url));
    switch(type){
      case 1:
        _fileCacheImageMap.remove(url);
        break;
      case 2:
        _memoryCacheImageMap.remove(url);
        break;
    }
  }

  /*
   * @author Marinda
   * @date 2023/9/7 17:05
   * @description 创建文件
   */
  static Future<File> _createFile(Uint8List uint8list) async{
    List<int> result = uint8list.toList();
    var dir = await path.getApplicationDocumentsDirectory();
    var filePath = "${dir.path}/${Uuid().v4()}.png";
    File file = File(filePath);
    await file.writeAsBytes(result);
    return file;
  }

  /*
   * @author Marinda
   * @date 2023/9/7 15:45
   * @description 下载图像
   */
   static downloadImage(String url) async{
     dio.ResponseBody responseBody = await Request.requestImage(url,method: HttpMethods.GET.value);
     final Completer<Uint8List> completer = Completer<Uint8List>.sync();
     final List<List<int>> chunks = <List<int>>[];
     int contentLength = 0;
      responseBody.stream.listen((List<int> chunk) {
       chunks.add(chunk);
       contentLength += chunk.length;
     }, onDone: () {
       final Uint8List bytes = Uint8List(contentLength);
       int offset = 0;
       for (List<int> chunk in chunks) {
         bytes.setRange(offset, offset + chunk.length, chunk);
         offset += chunk.length;
       }
       completer.complete(bytes);
     }, onError: completer.completeError, cancelOnError: true);
    Uint8List uint8list = await completer.future;
    return uint8list;
  }

  /*
   * @author Marinda
   * @date 2023/9/7 17:10
   * @description 移除缓存
   */
  static void removeCache(){
     _fileCacheImageMap = {};
     _memoryCacheImageMap = {};
  }
  
  /*
   * @author Marinda
   * @date 2023/9/7 17:11
   * @description 构建图片控件
   */
  static Widget buildImageWidget(String url,int type){
    Widget? widget;
    switch(type){
      case 1:
        widget = Image.file(getImageValue(url,1),fit: BoxFit.fill);
        break;
      case 2:
        widget = Image.memory(getImageValue(url,2),fit: BoxFit.fill);
        break;
    }
    return widget ?? Container();
  }
}