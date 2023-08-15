/**
 * @author Marinda
 * @date 2023/5/29 10:45
 * @description Socket实现类
 */
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:silentchat/entity/packet.dart';
import 'package:silentchat/entity/web_socket_message.dart';
import 'package:silentchat/enum/webocket_code.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/util/socket_util.dart';
import 'dart:io';
import 'package:web_socket_channel/io.dart';
import 'package:bot_toast/bot_toast.dart';
/*
 * @author Marinda
 * @date 2023/5/29 10:50
 * @description Socket实现类
 */
class SocketHandle {

  IOWebSocketChannel? webSocketChannel;
  SocketHandle(){
  }

  /*
   * @author Marinda
   * @date 2023/5/29 10:48
   * @description 连接
   */
  open(){
   WebSocket.connect(SocketUtil.url).then((value){
     webSocketChannel = IOWebSocketChannel(value);
     BotToast.showText(text: "连接成功！");
     listener();
   }).timeout(Duration(seconds: 3),onTimeout: (){
     BotToast.showText(text: "连接超时，重试连接！");
     Log.i("重新连接！");
    }).onError((error, stackTrace){
      Future.delayed(Duration(seconds: 3),(){
        BotToast.showText(text: "连接出现错误，重新连接！");
        Log.i("连接出现错误，重新连接！");
      });
   });
  }

  /*
   * @author Marinda
   * @date 2023/5/29 11:01
   * @description 写入
   */
  write(data) {
    webSocketChannel?.sink.add(data);
  }

  /*
   * @author Marinda
   * @date 2023/5/29 10:53
   * @description 监听
   */
  listener(){
    webSocketChannel!.stream.listen((data) {
      var message = json.decode(data);
      print('socket接收: ${message}');
      Packet packet = Packet.fromJson(message);
      print('packet: ${packet.toJson()}');
      int code = packet.type!;
      Map<String,dynamic> result = {
        "code": code
      };
      WebSocketMessage webSocketMessage = WebSocketMessage.fromJson(result);
      webSocketMessage.code?.cbFn?.call(packet);
      Log.i("Socket监听数据: ${message}");
    },onDone: (){
      Log.i("完成监听");
    });
  }

  /*
   * @author Marinda
   * @date 2023/5/29 10:51
   * @description 断开连接
   */
  close() async{
    if(webSocketChannel != null){
      webSocketChannel?.sink.close();
      webSocketChannel = null;
    }
  }
}