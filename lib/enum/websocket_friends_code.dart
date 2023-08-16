import 'package:get/get.dart';
import 'package:silentchat/socket/socket_friends_on_message.dart';
import 'package:silentchat/socket/socket_on_message.dart';
enum WebSocketFriendsCode{
  //添加好友
  append(1, cbFn:SocketFriendsOnMessage.append),
  accept(2, cbFn:SocketFriendsOnMessage.accept),
  refuse(3,cbFn:SocketFriendsOnMessage.refuse);

  final int code;

  final Function? cbFn;
  const WebSocketFriendsCode(this.code, {this.cbFn});

  static WebSocketFriendsCode? getWebSocketCodeEnum(int code) {
    return WebSocketFriendsCode.values
        .firstWhereOrNull((WebSocketCode) => WebSocketCode.code == code);
  }
}