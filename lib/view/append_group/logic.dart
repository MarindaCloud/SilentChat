import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/chat_info.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/group_user_info.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/group_api.dart';
import 'package:silentchat/network/api/group_info_api.dart';
import 'package:silentchat/network/api/message_api.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/message/logic.dart';
import 'package:bot_toast/bot_toast.dart';
import 'state.dart';

class AppendGroupLogic extends GetxController {
  final AppendGroupState state = AppendGroupState();
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/7/24 10:59
   * @description 构建联系人列表
   */
  buildContactList([List<User>? list, bool chooseFlag = false]) {
    List<User> friendsList = list ?? userState.friendUserList;
    Log.i("朋友列表: ${friendsList.map((e) => e.toJson()).toList()}");
    return friendsList.map((e) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(top: 10),
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //选中框
            chooseFlag
                ? Container(
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      image: DecorationImage(
                        image: Image.network(e.portrait!,).image,
                          fit: BoxFit.cover
                      )
                    ),
                  )
                : InkWell(
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: state.chooseUserList.contains(e) ? Colors.blue : Colors.transparent,
                          // borderRadius: BorderRadius.circular(10000),
                          border: Border.all(
                              color: Color.fromRGBO(204, 204, 204, 1),
                              width: 1)),
                    ),
                    onTap: () {
                      chooseUser(e);
                    },
                  ),
            //分割线
            SizedBox(
              width: 20,
            ),
            //用户名
            Container(
              child: Text("${e.username}",
                  style: TextStyle(color: Colors.black, fontSize: 14)),
            )
          ],
        ),
      );
    }).toList();
  }

  /*
   * @author Marinda
   * @date 2023/7/24 13:55
   * @description 选择用户
   */
  chooseUser(User user) {
    if (state.chooseUserList.contains(user)) {
      state.chooseUserList.remove(user);
    } else {
      state.chooseUserList.add(user);
    }
    Log.i("当前选择的用户：${user.username}");
  }

  /*
   * @author Marinda
   * @date 2023/7/24 14:10
   * @description 创建群聊方法
   */
  createGroup() async{
    Log.i("创建群聊");
    //群聊名是通过全部用户名称拼接的结果
    String groupName = "";
    String msg = "${userState.user.value.username}创建了该群聊";
    for(var element in state.chooseUserList){
      String userName = element.username ?? "";
      groupName += "${userName}、";
    }
    //如果群组名称不为空则视为存在选择的用户，则把当前创建群聊用户名添加至群名中
    if(groupName != ""){
      groupName += userState.user.value.username ?? "";
    }
    Log.i("群组名称：${groupName}");
    //插入群组数据
    Group group = Group(name: groupName,personMax: 20,adminMax: 20,portrait: "http://175.24.177.189:8080/assets/ac880ff4-cbff-4568-9484-09d19d9524cf.png");
    int result = await GroupAPI.insertGroup(group);
    //插入消息数据
    Message createGroupMsg = Message(content: msg,type: 1,time: DateTime.now());
    APIResult api = await MessageAPI.insertMessage(createGroupMsg);
    int messageId = api.data;
    if(result != -1){
      //异步插入，涉及到for循环，走同步怕耽误太多时间
      for(var element in state.chooseUserList){
        int uid = element.id ?? -1;
        GroupUserInfo groupUserInfo = GroupUserInfo(uid: uid,gid: result);
        GroupInfoAPI.insertGroupInfo(groupUserInfo);
        // ChatInfo chatInfo = ChatInfo(sendId: uid,receiverId: element.id,type: 2);
      }
      //这里是为了把当前创建群组用户添加至群组里
      if(state.chooseUserList.isNotEmpty){
        GroupUserInfo groupUserInfo = GroupUserInfo(uid: userState.user.value.id,gid: result);
        GroupInfoAPI.insertGroupInfo(groupUserInfo);
      }

      //插入ChatInfo
      ChatInfo groupChatInfo = ChatInfo(sendId: userState.user.value.id,receiverId: result,type: 2,mid: messageId);
      await MessageAPI.insertChatInfo(groupChatInfo);
      //  插入消息完毕后追加至该用户Message中
      MessageLogic messageLogic = Get.find<MessageLogic>();
      //这里需要把groupId重新带进去
      group.id = result;
      messageLogic.insertMessage(group, 2, createGroupMsg);
      BotToast.showText(text: "创建群聊成功！");
      Get.back();
      // await messageLogic.insertCacheRecord(receiverId, message);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
