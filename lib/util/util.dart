import 'dart:convert';

/**
 * @author Marinda
 * @date 2023/7/3 16:29
 * @description 通用工具类
 */
class GlobalUtil{


  /*
   * @author Marinda
   * @date 2023/7/3 16:32
   * @description 加密器
   */
  static String encoder(String data,String type){
    String encodeString = "";
    switch(type){
      case "base64":
        encodeString = base64.encode(data.codeUnits);
        break;
    }
    return encodeString;
  }


  /*
   * @author Marinda
   * @date 2023/7/3 16:34
   * @description 解码器
   */
  static String decoder(String encodeString,String type){
    String decodeResult = "";
    switch(type){
      case "base64":
        var decodeStr = base64.decode(encodeString);
        decodeResult = String.fromCharCodes(decodeStr);
        break;
    }
    return decodeResult;
  }
}