import 'package:silentchat/enum/webocket_code.dart';

/**
 * @author Marinda
 * @date 2023/6/16 18:01
 * @description WebSocketMessage
 */
class WebSocketMessage{
  WebSocketCode? code;
  
  WebSocketMessage({WebSocketCode? webSocketCode}){
    this.code = webSocketCode;
  }

  WebSocketMessage.fromJson(Map<String, dynamic> json) {
    // 后台脏数据
    if(json['code'] is String) {
      json['code'] = int.parse(json['code']);
    }
    code = WebSocketCode.getWebSocketCodeEnum(json['code']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(code != null) {
      data['code'] = code!.code;
    }
    return data;
  }
}