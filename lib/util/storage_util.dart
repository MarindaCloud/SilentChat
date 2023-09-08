import 'dart:convert';

import 'package:get_storage/get_storage.dart';
/**
 * @author Marinda
 * @date 2023/9/8 11:04
 * @description 缓存工具类
 */
class StorageUtil{

  static final storage = GetStorage();

  /*
   * @author Marinda
   * @date 2023/9/8 11:16
   * @description 写入数据
   */
  static write(String key,dynamic value) async{
    await storage.write(key, value);
  }

  /*
   * @author Marinda
   * @date 2023/9/8 11:16
   * @description 读取数据
   */
  static read(String key) async{
    assert(await storage.read(key) != null );
    return await storage.read(key);
  }

  /*
   * @author Marinda
   * @date 2023/9/8 11:18
   * @description 转换json目标对象
   */
  static parseKeyElement(String key,dynamic type) async{
    var readElement = read(key);
    var element = json.decode(readElement);
    var value = type.fromJSON(element);
    return value;
  }

  /*
   * @author Marinda
   * @date 2023/9/8 11:28
   * @description 写入对象 非存在则写入
   */
  static writeKeyElement(String key,dynamic element) async{
    if(read(key) != null){
      return;
    }
    String jsonStr = json.encode(element);
    await write(key, jsonStr);
  }
}