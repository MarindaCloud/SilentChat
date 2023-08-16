import 'package:get/get.dart';
import 'package:silentchat/socket/socket_friends_on_message.dart';
import 'package:silentchat/socket/socket_groups_on_message.dart';
import 'package:silentchat/socket/socket_on_message.dart';
/**
 * @author Marinda
 * @date 2023/8/16 16:11
 * @description
 */
enum WebSocketGroupsCode{
  //添加好友
  create(1, cbFn: SocketGroupsOnMessage.create);

  final int code;

  final Function? cbFn;
  const WebSocketGroupsCode(this.code, {this.cbFn});

  static WebSocketGroupsCode? getWebSocketCodeEnum(int code) {
    return WebSocketGroupsCode.values
        .firstWhereOrNull((WebSocketCode) => WebSocketCode.code == code);
  }
}