/**
 * @author Marinda
 * @date 2023/5/29 10:45
 * @description Socket实现类
 */
import 'package:dio/dio.dart';
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
    try{
      open();
    }catch(e){
      //重连3秒
      Future.delayed(Duration(seconds: 3),(){
        open();
      });
    }
  }

  /*
   * @author Marinda
   * @date 2023/5/29 10:48
   * @description 连接
   */
  open() async{
   WebSocket.connect(SocketUtil.url).then((value){
     webSocketChannel = IOWebSocketChannel(value);
     BotToast.showText(text: "连接成功！");
     listener();
   }).timeout(Duration(seconds: 3),onTimeout: (){
     open();
     Log.i("重新连接！");
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

      Log.i("Socket监听数据: ${data}");
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
    }
  }
}