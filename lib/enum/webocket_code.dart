import 'package:get/get.dart';
import 'package:silentchat/socket/socket_on_message.dart';
enum WebSocketCode{
  //接收消息
  chatMessage(2, cbFn: SocketOnMessage.chatMessage);

  final int code;

  final Function? cbFn;
  const WebSocketCode(this.code, {this.cbFn});

  static WebSocketCode? getWebSocketCodeEnum(int code) {
    return WebSocketCode.values
        .firstWhereOrNull((WebSocketCode) => WebSocketCode.code == code);
  }
}