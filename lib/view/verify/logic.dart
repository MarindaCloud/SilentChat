import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/friend.dart';
import 'package:silentchat/entity/friends_verify.dart';
import 'package:silentchat/entity/packet.dart';
import 'package:silentchat/entity/packet_verify_friend.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/entity/verify.dart';
import 'package:silentchat/entity/verify_view_info.dart';
import 'package:silentchat/network/api/friends_api.dart';
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
    state.value = args;
    initVerify();
    // TODO: implement onInit
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/7/5 10:47
   * @description 初始化验证数据
   */

  initVerify() async{
    await initVerifyInfo();
    initVerifyViewInfo();
  }

  /*
   * @author Marinda
   * @date 2023/7/5 10:47
   * @description 验证消息转视图数据
   */
  void initVerifyViewInfo() async{
    List<VerifyViewInfo> verifyViewInfoList = [];
    List<Verify> distinctVerifyList = state.verifyList.toSet().toList();
    Log.i("去重后的验证消息列表: ${distinctVerifyList}");
    for(var element in distinctVerifyList){
      if(element is FriendsVerify){
        int uid = element?.uid ?? -1;
        int tid = element?.tid ?? -1;
        if(uid == -1 || tid == -1){ break;}
        //如果uid == 用户缓存中的当前用户uid,跳出
        if(uid == userState.uid.value){
          continue;
        }
        User targetUser = await UserAPI.selectByUid(uid);
        Log.i("目标用户：${targetUser.toJson()}");
        VerifyViewInfo viewInfo = VerifyViewInfo(user: targetUser,verify: element);
        verifyViewInfoList.add(viewInfo);
      }
    }
    Log.i("当前验证消息视图中的列表长度：${verifyViewInfoList.length}");
    state.verifyViewInfo.value = verifyViewInfoList;
  }


  /*
   * @author Marinda
   * @date 2023/7/4 18:43
   * @description 构建朋友信息列表
   */
  List<Widget> buildFriendsVerifyList(){
    List<Widget> widgetList = [];
    Log.i("更新！");
    if(state.verifyViewInfo.isEmpty){
      Widget emptyWidget = Container(
        height: 200.rpx,
        child: Center(child: Text("暂无收到好友验证消息")),
      );
      widgetList.add(emptyWidget);
    }
    for(var verifyViewInfo in state.verifyViewInfo){
      FriendsVerify friendsVerify = verifyViewInfo.verify as FriendsVerify;
      //朋友验证对象
      Widget widget = Container(
           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
           height: 300.rpx,
           child: Row(
             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               //头像
               Container(
                 margin: EdgeInsets.only(right: 30.rpx),
                 width: 250.rpx,
                 height: 250.rpx,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10000),
                     image: DecorationImage(
                         image: Image.network(
                             "${verifyViewInfo.user!.portrait}")
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
                         style: TextStyle(
                             color: Colors.black, fontSize: 16)),
                     SizedBox(height: 50.rpx),
                     Container(
                         child: Text("${verifyViewInfo.user?.signature ?? "无"}",
                             style: TextStyle(
                                 color: Colors.black, fontSize: 16)))
                   ],
                 ),
               ),
               Expanded(child: SizedBox()),
               state.userControlMap.containsKey(friendsVerify.id) ?
                   Container(
                     child: Text("已${getStatusName(friendsVerify.status ?? -1)}"),
                   )
                   :Container(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     // Expanded(child: SizedBox()),
                     Container(
                       margin: EdgeInsets.only(left: 50.rpx),
                       child: TextButton(
                         child: Text("同意",
                             style:
                             TextStyle(color: Colors.white)),
                         onPressed: () {
                           acceptVerify(verifyViewInfo.verify as FriendsVerify);
                         },
                         style: ButtonStyle(
                             backgroundColor:
                             MaterialStateProperty.all(
                                 Colors.blue)),
                       ),
                     ),
                     // Expanded(child: SizedBox()),
                     Container(
                       margin: EdgeInsets.only(left: 50.rpx),
                       child: TextButton(
                         child: Text("拒绝",
                             style:
                             TextStyle(color: Colors.white)),
                         onPressed: () {
                           refuseVerify(verifyViewInfo.verify as FriendsVerify);
                         },
                         style: ButtonStyle(
                             backgroundColor:
                             MaterialStateProperty.all(
                                 Colors.red)),
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
  String getStatusName(int status){
    String resultString = "";
    switch(status){
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
  initVerifyInfo() async{
    List<FriendsVerify> resultList = [];
    var value = state.value;
    int uid = userState.uid.value;
    int type = value["type"];
    switch(type){
      //用户
      case 1:
        List<FriendsVerify> friendsVerifyList = await VerifyAPI.selectByUidOrTidList(uid);
        //过滤一下数据，作为接收方
        List<FriendsVerify> filterVerifyList = friendsVerifyList.where((element) => element.tid == userState.uid.value).toList();
        resultList = filterVerifyList;
        Log.i("朋友验证列表：${filterVerifyList.map((e) => e.toJson()).toList()}");
        break;
    }
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
  saveUserControl(){
    List<Verify> filterVerifyList = state.verifyList.where((element){
      if(element is FriendsVerify){
        int status = element.status ?? -1;
        return status > 0;
      }
      return false;
    }).toList();
    Map<int,int> statusControlMap = {};
    for(Verify element in filterVerifyList){
      if(element is FriendsVerify){
        int id = element.id ?? -1;
        int status = element.status ?? -1;
        if(!statusControlMap.containsKey(id)){
          statusControlMap[id] = status;
        }
      }
    }
    state.userControlMap = statusControlMap;
    Log.i("用户操作记录Map: ${state.userControlMap}");
  }

  /*
   * @author Marinda
   * @date 2023/8/16 15:05
   * @description 发包
   */
  sendPacket(PacketVerifyFriend packetVerifyFriend){
    Packet packet = Packet(type: 3,object: packetVerifyFriend);
    var packetInfo = json.encode(packet);
    Log.i("发送Packet信息: ${packetInfo}");
    socketHandle.write(packetInfo);
  }


  /*
   * @author Marinda
   * @date 2023/7/5 15:14
   * @description 同意验证请求
   * 总共做两件事
   * 修改后台数据表中的验证状态
   * 朋友关系表中新增同意的目标用户的好友关系
   */
  acceptVerify(FriendsVerify friendsVerify) async{
    // 0 未处理 1 通过 2拒绝
    friendsVerify.status = 1;
    bool flag = await VerifyAPI.updateFriendsVerify(friendsVerify);
    if(flag){
      Friend friend = Friend(uid: userState.uid.value,fid: friendsVerify.uid ?? 0);
      int result = await FriendsAPI.insertFriends(friend);
      Friend targetFriend = Friend(uid: friendsVerify.uid ?? 0,fid: userState.uid.value);
      int result2 = await FriendsAPI.insertFriends(targetFriend);
      //添加失败
      if(result == -1 || result2 == -1){
        BotToast.showText(text: "添加好友出现错误！");
        return;
      }
      PacketVerifyFriend packetVerifyFriend = PacketVerifyFriend(code: 2,uid: userState.uid.value,receiverId: friendsVerify.uid,verifyMsg: "通过好友请求");
      sendPacket(packetVerifyFriend);
      BotToast.showText(text: "已同意该用户好友申请！");
    }
    initVerify();
    Get.back(result: "accept");
  }



  /*
   * @author Marinda
   * @date 2023/7/6 10:43
   * @description
   */
  refuseVerify(FriendsVerify friendsVerify) async{
    // 0 未处理 1 通过 2拒绝
    friendsVerify.status = 2;
    bool flag = await VerifyAPI.updateFriendsVerify(friendsVerify);
    if(!flag){
      BotToast.showText(text: "拒绝好友出现错误！");
      return;
    }
    PacketVerifyFriend packetVerifyFriend = PacketVerifyFriend(code: 3,uid: userState.uid.value,receiverId: friendsVerify.tid,verifyMsg: "拒绝了好友请求");
    sendPacket(packetVerifyFriend);
    BotToast.showText(text: "已拒绝该用户好友请求！");
    initVerify();
  }

}
