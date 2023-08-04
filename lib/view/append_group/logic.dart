import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/group_user_info.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/group_api.dart';
import 'package:silentchat/network/api/group_info_api.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/message/logic.dart';

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
    List<User> friendsList = list ?? userState.friendUserList.value;
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
    for(var element in state.chooseUserList){
      String userName = element.username ?? "";
      groupName += "${userName}、";
    }
    Log.i("群组名称：${groupName}");
    Group group = Group(name: groupName,personMax: 20,adminMax: 20);
    int result = await GroupAPI.insertGroup(group);
    if(result != -1){
      //异步插入，涉及到for循环，走同步怕耽误太多时间
      for(var element in state.chooseUserList){
        int uid = element.id ?? -1;
        GroupUserInfo groupUserInfo = GroupUserInfo(uid: uid,gid: result);
        GroupInfoAPI.insertGroupInfo(groupUserInfo);
      }
    //  创建群组完毕之后创建
      MessageLogic messageLogic = Get.find<MessageLogic>();

      // await messageLogic.insertCacheRecord(receiverId, message);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
