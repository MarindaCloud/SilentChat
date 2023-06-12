import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
class IndexState {
  Widget contentWidget = Container();
  final index = 0.obs;
  IOWebSocketChannel? webSocketChannel;
  final showUserInfo = false.obs;
  IndexState() {
    ///Initialize variables
  }
}
