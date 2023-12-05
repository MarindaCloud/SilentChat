import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/friend.dart';
import 'package:silentchat/entity/friends_verify.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/group_verify.dart';
import 'package:silentchat/entity/packet.dart';
import 'package:silentchat/entity/packet_verify_friend.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/entity/verify.dart';
import 'package:silentchat/entity/verify_group_view_info.dart';
import 'package:silentchat/entity/verify_view_info.dart';
import 'package:silentchat/network/api/friends_api.dart';
import 'package:silentchat/network/api/group_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/network/api/verify_api.dart';
import 'package:silentchat/socket/socket_handle.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'state.dart';
import 'package:bot_toast/bot_toast.dart';

/**
 * @author Marinda
 * @date 2023/7/4 11:34
 * @description  验证的相关控制器处理
 */
class VerifyLogic extends GetxController {
  final VerifyState state = VerifyState();
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;
  final SocketHandle socketHandle = Get.find<SocketHandle>();

  @override
  void onInit() {
    var args = Get.arguments;
    state.value = args["type"];
    initVerify();
    // TODO: implement onInit
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/7/5 10:47
   * @description 初始化验证数据
   */

  initVerify() async {
    switch (state.value) {
      case 1:
        await initFriendsVerifyInfo();
        initVerifyViewInfo();
        break;
      case 2:
        await initGroupVerify();
        break;
    }
  }

  /*
   * @author Marinda
   * @date 2023/12/2 14:58
   * @description 初始化群聊验证消息
   */
  initGroupVerify() async {
    await loadGroupVerifyInfo();
    saveUserControl();
  }

  /*
     * @author Marinda
     * @date 2023/12/5 11:32
     * @description
     * 同意验证请求，重构数据表逻辑，新增触发器，这里只需要做一个修改即可
     */
  acceptVerify(Verify verify) async {
    bool flag = false;
    switch (state.value) {
      case 1:
        FriendsVerify element = verify as FriendsVerify;
        element.status = 1;
        flag = await VerifyAPI.updateFriendsVerify(element);
        break;
      case 2:
        GroupVerify element = verify as GroupVerify;
        element.status = 1;
        flag =await VerifyAPI.updateGroupVerify(element);
        break;
    }
    initVerify();
    if(!flag){
      BotToast.showText(text: "同意请求失败！");
      return;
    }
    BotToast.showText(text: "通过请求成功！");
    // Get.back(result: "accept");
  }

  /*
   * @author Marinda
   * @date 2023/12/2 15:04
   * @description 加载群聊验证信息
   */
  loadGroupVerifyInfo() async {
    List<GroupVerify> groupVerify =
        await VerifyAPI.selectListByUserId(userState.uid.value);
    Log.i("${userState.user.value.username}群组验证列表: ${groupVerify.length}");
    state.verifyList.value = groupVerify;
    List<VerifyGroupViewInfo> verifyGroupViewInfoList = [];
    for (var element in groupVerify) {
      int gid = element.gid ?? -1;
      Group group = await GroupAPI.selectById(gid);
      VerifyGroupViewInfo verifyGroupViewInfo =
          VerifyGroupViewInfo(group: group, verify: element);
      verifyGroupViewInfoList.add(verifyGroupViewInfo);
    }
    state.verifyGroupViewInfo.value = verifyGroupViewInfoList;
    Log.i("验证群组消息viewInfo：${state.verifyGroupViewInfo.length}");
  }

  /*
   * @author Marinda
   * @date 2023/7/5 10:47
   * @description 验证消息转视图数据
   */
  void initVerifyViewInfo() async {
    List<VerifyViewInfo> verifyViewInfoList = [];
    List<Verify> distinctVerifyList = state.verifyList.toSet().toList();
    Log.i("去重后的验证消息列表: ${distinctVerifyList}");
    for (var element in distinctVerifyList) {
      if (element is FriendsVerify) {
        int uid = element?.uid ?? -1;
        int tid = element?.tid ?? -1;
        if (uid == -1 || tid == -1) {
          break;
        }
        //如果uid == 用户缓存中的当前用户uid,跳出
        if (uid == userState.uid.value) {
          continue;
        }
        User targetUser = await UserAPI.selectByUid(uid);
        Log.i("目标用户：${targetUser.toJson()}");
        VerifyViewInfo viewInfo =
            VerifyViewInfo(user: targetUser, verify: element);
        verifyViewInfoList.add(viewInfo);
      }
    }
    Log.i("当前验证消息视图中的列表长度：${verifyViewInfoList.length}");
    state.verifyFriendsViewInfo.value = verifyViewInfoList;
  }

  /*
   * @author Marinda
   * @date 2023/12/2 15:09
   * @description 构建群组验证消息
   */
  List<Widget> buildGroupsVerifyList() {
    List<Widget> widgetList = [];
    if (state.verifyList.isEmpty) {
      Widget emptyWidget = Container(
        height: 200.rpx,
        child: Center(child: Text("暂无收到验证消息")),
      );
      widgetList.add(emptyWidget);
    }
    for (var verifyViewInfo in state.verifyGroupViewInfo) {
      GroupVerify groupVerify = verifyViewInfo.verify as GroupVerify;
      int status = groupVerify?.status ?? -1;
      //朋友验证对象
      Widget widget = Container(
        color: Colors.grey.withOpacity(.3),
        margin: EdgeInsets.only(bottom: 50.rpx),
        padding: EdgeInsets.only(
            bottom: 50.rpx, left: 50.rpx, right: 50.rpx, top: 50.rpx),
        child: Row(
          children: [
            //头像
            Container(
              margin: EdgeInsets.only(right: 30.rpx),
              width: 250.rpx,
              height: 250.rpx,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10000),
                  image: DecorationImage(
                      image: Image.network("${verifyViewInfo.group!.portrait}")
                          .image,
                      fit: BoxFit.cover)),
            ),
            //信息
            Container(
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${verifyViewInfo.group?.name}",
                      style: TextStyle(color: Colors.blue, fontSize: 16)),
                  SizedBox(height: 50.rpx),
                  Container(
                      child: Text("${verifyViewInfo.group?.description ?? "无"}",
                          style: TextStyle(color: Colors.black, fontSize: 16)))
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            state.userControlMap.containsKey(groupVerify.id)
                ? Container(
                    child: Text("已${getStatusName(status)}"),
                  )
                : Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Expanded(child: SizedBox()),
                        Container(
                          margin: EdgeInsets.only(left: 50.rpx),
                          child: TextButton(
                            child: Text("同意",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              acceptVerify(verifyViewInfo.verify!);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
                          ),
                        ),
                        // Expanded(child: SizedBox()),
                        Container(
                          margin: EdgeInsets.only(left: 50.rpx),
                          child: TextButton(
                            child: Text("拒绝",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              refuseVerify(
                                  verifyViewInfo.verify as FriendsVerify);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      );
      widgetList.add(widget);
    }
    return widgetList;
  }

  /*
   * @author Marinda
   * @date 2023/7/4 18:43
   * @description 构建朋友信息列表
   */
  List<Widget> buildFriendsVerifyList() {
    List<Widget> widgetList = [];
    if (state.verifyFriendsViewInfo.isEmpty) {
      Widget emptyWidget = Container(
        height: 200.rpx,
        child: Center(child: Text("暂无收到好友验证消息")),
      );
      widgetList.add(emptyWidget);
    }
    for (var verifyViewInfo in state.verifyFriendsViewInfo) {
      FriendsVerify friendsVerify = verifyViewInfo.verify as FriendsVerify;
      //朋友验证对象
      Widget widget = Container(
        color: Colors.grey.withOpacity(.3),
        margin: EdgeInsets.only(bottom: 50.rpx),
        padding: EdgeInsets.only(
            bottom: 50.rpx, left: 50.rpx, right: 50.rpx, top: 50.rpx),
        child: Row(
          children: [
            //头像
            Container(
              margin: EdgeInsets.only(right: 30.rpx),
              width: 250.rpx,
              height: 250.rpx,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10000),
                  image: DecorationImage(
                      image: Image.network("${verifyViewInfo.user!.portrait}")
                          .image,
                      fit: BoxFit.cover)),
            ),
            //信息
            Container(
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${verifyViewInfo.user?.username}",
                      style: TextStyle(color: Colors.blue, fontSize: 16)),
                  SizedBox(height: 50.rpx),
                  Container(
                      child: Text("${verifyViewInfo.user?.signature ?? "无"}",
                          style: TextStyle(color: Colors.black, fontSize: 16)))
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            state.userControlMap.containsKey(friendsVerify.id)
                ? Container(
                    child:
                        Text("已${getStatusName(friendsVerify.status ?? -1)}"),
                  )
                : Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Expanded(child: SizedBox()),
                        Container(
                          margin: EdgeInsets.only(left: 50.rpx),
                          child: TextButton(
                            child: Text("同意",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              acceptVerify(friendsVerify);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
                          ),
                        ),
                        // Expanded(child: SizedBox()),
                        Container(
                          margin: EdgeInsets.only(left: 50.rpx),
                          child: TextButton(
                            child: Text("拒绝",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              refuseVerify(friendsVerify);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      );
      widgetList.add(widget);
    }
    return widgetList;
  }

  /*
   * @author Marinda
   * @date 2023/7/6 11:06
   * @description 获取状态的名称
   */
  String getStatusName(int status) {
    String resultString = "";
    switch (status) {
      case 1:
        resultString = "同意";
        break;
      case 2:
        resultString = "拒绝";
        break;
    }
    return resultString;
  }

  /*
   * @author Marinda
   * @date 2023/7/4 16:46
   * @description 初始化验证信息
   */
  initFriendsVerifyInfo() async {
    List<FriendsVerify> resultList = [];
    var value = state.value;
    int uid = userState.uid.value;
    List<FriendsVerify> friendsVerifyList = await VerifyAPI.selectByUidOrTidList(uid);
    //过滤一下数据，作为接收方
    List<FriendsVerify> filterVerifyList = friendsVerifyList
        .where((element) => element.tid == userState.uid.value)
        .toList();
    resultList = filterVerifyList;
    Log.i("朋友验证列表：${filterVerifyList.map((e) => e.toJson()).toList()}");
    state.verifyList.value = resultList;
    saveUserControl();
    //save用户操作记录
    Log.i("验证消息列表：${state.verifyList.length}");
  }

  /*
   * @author Marinda
   * @date 2023/7/6 10:51
   * @description 储存用户操作记录
   */
  saveUserControl() {
    List<Verify> filterVerifyList = state.verifyList.where((element) {
      if (element is GroupVerify) {
        int status = element.status ?? -1;
        return status > 0;
      }
      if (element is FriendsVerify) {
        int status = element.status ?? -1;
        return status > 0;
      }
      return false;
    }).toList();
    Map<int, int> statusControlMap = {};
    for (Verify element in filterVerifyList) {
      if (element is FriendsVerify) {
        int id = element.id ?? -1;
        int status = element.status ?? -1;
        if (!statusControlMap.containsKey(id)) {
          statusControlMap[id] = status;
        }
      } else {
        if (element is GroupVerify) {
          int id = element.id ?? -1;
          int status = element.status ?? -1;
          if (!statusControlMap.containsKey(id)) {
            statusControlMap[id] = status;
          }
        }
      }
      state.userControlMap = statusControlMap;
      Log.i("用户操作记录Map: ${state.userControlMap}");
    }
  }

  /*
   * @author Marinda
   * @date 2023/8/16 15:05
   * @description 发包
   */
  sendPacket(PacketVerifyFriend packetVerifyFriend) {
    Packet packet = Packet(type: 3, object: packetVerifyFriend);
    var packetInfo = json.encode(packet);
    Log.i("发送Packet信息: ${packetInfo}");
    socketHandle.write(packetInfo);
  }

  /*
   * @author Marinda
   * @date 2023/7/6 10:43
   * @description
   */
  refuseVerify(Verify verify) async {
    int receiverId = 0;
    switch(state.value){
      case 1:
        FriendsVerify element = verify as FriendsVerify;
        receiverId = element.tid ?? -1;
        await VerifyAPI.updateFriendsVerify(element);
        break;
      case 2:
        GroupVerify element = verify as GroupVerify;
        receiverId = element.gid ?? -1;
        await VerifyAPI.updateGroupVerify(element);
        break;
    }
    initVerify();
    PacketVerifyFriend packetVerifyFriend = PacketVerifyFriend(
        code: 3,
        uid: userState.uid.value,
        receiverId: receiverId,
        verifyMsg: "拒绝了好友请求");
    sendPacket(packetVerifyFriend);
    BotToast.showText(text: "已拒绝该用户好友请求！");

  }
}
