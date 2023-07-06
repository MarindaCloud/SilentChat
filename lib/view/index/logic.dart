import 'dart:convert';

import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/friend.dart';
import 'package:silentchat/entity/packet.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/friends_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/socket/socket_handle.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/contact/view.dart';
import 'package:silentchat/view/dynamic/view.dart';
import 'package:silentchat/view/message/view.dart';

import 'state.dart';

class IndexLogic extends GetxController {
  final IndexState state = IndexState();
  final socketHandle = Get.find<SocketHandle>();
  final userLogic = Get.find<UserLogic>();
  final userState = Get.find<UserLogic>().state;
  @override
  void onInit() {
    state.contentWidget = Get.arguments;
    initSocket();
    initFriendsList();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  /*
   * @author Marinda
   * @date 2023/5/29 10:54
   * @description 连接Socket
   */
  void initSocket() async{
    state.webSocketChannel = socketHandle.webSocketChannel;
    User user = userState.user.value;
    Packet packet = Packet(type: 1, object: user);
    String packetJSON = json.encode(packet);
    Log.i("初始化Socket连接包：${packetJSON}");
    socketHandle.write(packetJSON);
  }

  /*
   * @author Marinda
   * @date 2023/6/9 18:02
   * @description 初始化朋友列表
   */
  initFriendsList() async{
    List<Friend> friendList = await FriendsAPI.selectByUid();
    List<User> userList = [];
    for(Friend friend in friendList){
      int friendId = friend?.fid ?? -1;
      User user  = await UserAPI.selectByUid(friendId);
      userList.add(user);
    }
    userState.friendUserList.value = userList.toSet().toList();
    Log.i("朋友用户详情列表List: ${userList.map((e) => e.toJson()).toList()}");
  }

  /*
   * @author Marinda
   * @date 2023/5/25 16:21
   * @description 切换视图
   */
  changeNavView(int index){
    print("index: ${state.index.value}");
    state.index.value = index;
    switch(state.index.value){
      //消息
      case 0:
        state.contentWidget = MessagePage();
        break;
      //  联系人
      case 1:
        state.contentWidget = ContactPage();
        break;
      //  动态
      case 2:
        state.contentWidget = DynamicPage();
        break;
    }
    update();
  }

}
