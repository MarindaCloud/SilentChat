import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/friend.dart';
import 'package:silentchat/entity/friends_view_info.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/group_user_info.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/enum/receiver_type.dart';
import 'package:silentchat/network/api/friends_api.dart';
import 'package:silentchat/network/api/group_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:silentchat/util/log.dart';
import 'state.dart';

/**
 * @author Marinda
 * @date 2023/5/25 16:10
 * @description  联系人逻辑
 */
class ContactLogic extends GetxController {
  final ContactState state = ContactState();
  final SystemLogic systemLogic = Get.find<SystemLogic>();
  final SystemState systemState = Get.find<SystemLogic>().state;
  final userLogic = Get.find<UserLogic>();
  final userState = Get.find<UserLogic>().state;

  @override
  void onInit() {
    Log.i("联系人初始化完毕！");
    initFriendsInfo();
    initGroupsInfo();
  }



  /*
   * @author Marinda
   * @date 2023/7/4 15:16
   * @description 跳转至朋友验证消息
   */
  toFriendsVerify() async{
    Map<String,dynamic> args = {
      "type": 1
    };
    var result = await Get.toNamed(AppPage.verify,arguments: args);
    if(result == "accept"){
      await userLogic.initFriendsList();
      initFriendsInfo();
      Log.i("通过好友请求，重载好友列表！");
    }
  }

  /*
   * @author Marinda
   * @date 2023/6/12 11:02
   * @description 初始化朋友信息
   */
  void initFriendsInfo(){
    List<User> userList = userState.friendUserList;
    Map<String,List<FriendsViewInfo>> cacheFriendUserMap = {};
    List<FriendsViewInfo> friendsViewInfoList = [];
    for(User user in userList){
      FriendsViewInfo friendsViewInfo = FriendsViewInfo(element: user);
      String userName = user.username ?? "";
      String letter = PinyinHelper.getShortPinyin(userName.substring(0,1)).toUpperCase();
      friendsViewInfo.letter = letter;
      friendsViewInfoList.add(friendsViewInfo);
    }
    List<FriendsViewInfo> filterList = friendsViewInfoList.toSet().toList();
    Log.i("朋友信息列表：${filterList}");
    // //默认字母排序为A-Z，所以还需要对用户信息做一个字母Map缓存排序
    for(int i = 0;i<state.letterList.length;i++){
      var letter = state.letterList[i];
      for(FriendsViewInfo friendsViewInfo in filterList){
          if(friendsViewInfo.letter == letter){
            //如果存在
            if(cacheFriendUserMap.containsKey(letter)){
              //缓存
              List<FriendsViewInfo> cacheNewList = [];
              List<FriendsViewInfo> cacheViewInfoList = cacheFriendUserMap[letter] ?? [];
              cacheNewList.addAll(cacheViewInfoList);
              cacheNewList.add(friendsViewInfo);
              cacheFriendUserMap[letter] = cacheNewList;
            }else{
              cacheFriendUserMap[letter] = [friendsViewInfo];
            }
          }
      }
    }
    state.friendsCacheMap.value = cacheFriendUserMap;
    print('各首字母信息：${cacheFriendUserMap}');
  }

  /*
   * @author Marinda
   * @date 2023/8/10 16:32
   * @description 初始化群组信息
   */
  void initGroupsInfo() async{
    List<GroupUserInfo> userGroupInfoList = await GroupAPI.selectUserGroups();
    Map<String,List<FriendsViewInfo>> cacheFriendUserMap = {};
    List<FriendsViewInfo> friendsViewInfoList = [];
    for(var groupInfo in userGroupInfoList){
      int groupId = groupInfo.gid ?? -1;
      Group group = await GroupAPI.selectById(groupId);
      FriendsViewInfo friendsViewInfo = FriendsViewInfo(element: group);
      String groupName = group.name ?? "";
      String letter = PinyinHelper.getShortPinyin(groupName.substring(0,1)).toUpperCase();
      friendsViewInfo.letter = letter;
      friendsViewInfoList.add(friendsViewInfo);
    }
    List<FriendsViewInfo> filterList = friendsViewInfoList.toSet().toList();
    Log.i("群组信息列表：${filterList}");
    // //默认字母排序为A-Z，所以还需要对用户信息做一个字母Map缓存排序
    for(int i = 0;i<state.letterList.length;i++){
      var letter = state.letterList[i];
      for(FriendsViewInfo friendsViewInfo in filterList){
        if(friendsViewInfo.letter == letter){
          //如果存在
          if(cacheFriendUserMap.containsKey(letter)){
            //缓存
            List<FriendsViewInfo> cacheNewList = [];
            List<FriendsViewInfo> cacheViewInfoList = cacheFriendUserMap[letter] ?? [];
            cacheNewList.addAll(cacheViewInfoList);
            cacheNewList.add(friendsViewInfo);
            cacheFriendUserMap[letter] = cacheNewList;
          }else{
            cacheFriendUserMap[letter] = [friendsViewInfo];
          }
        }
      }
    }
    state.groupsCacheMap.value = cacheFriendUserMap;
    print('各首字母信息：${cacheFriendUserMap}');
  }


  /*
   * @author Marinda
   * @date 2023/5/25 16:58
   * @description 构建朋友控件列表
   */
  List<Widget> buildFriends(){
    List<Widget> list = [];
    for(String letter in state.friendsCacheMap.keys){
      List<FriendsViewInfo> friendsViewInfoList = state.friendsCacheMap[letter] ?? [];
      Widget child = Container(
        margin: EdgeInsets.only(bottom: 50.rpx),
        child: Column(
          children: [
            //拼音分组
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 30.rpx),
              child: Text(
                letter,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14
                ),
              ),
            ),
            //用户列表
            Container(
              child: Column(
                children: buildFriendsInfo(friendsViewInfoList),
              ),
            )
          ],
        ),
      );
      list.add(child);
    }
    return list;
  }

  /*
   * @author Marinda
   * @date 2023/8/16 15:26
   * @description 插入至当前联系人列表
   */
  insertContact(User user){
    String userName = user.username ?? "";
    String letter = PinyinHelper.getShortPinyin(userName.substring(0,1)).toUpperCase();
    FriendsViewInfo friendsViewInfo = FriendsViewInfo(element: user,letter: letter);
    if(state.friendsCacheMap.containsKey(letter)){
      List<FriendsViewInfo> list = state.friendsCacheMap[letter] ?? [];
      List<FriendsViewInfo> cloneList = [];
      cloneList.addAll(list);
      cloneList.add(friendsViewInfo);
      state.friendsCacheMap[letter] = cloneList;
    }else{
      state.friendsCacheMap[letter] = [friendsViewInfo];
    }
    state.friendsCacheMap.refresh();
    Log.i("插入联系人：${user.username}完毕！");
  }


  /*
   * @author Marinda
   * @date 2023/8/10 16:32
   * @description 构建群组列表
   */
  List<Widget> buildGroups(){
    List<Widget> list = [];
    for(String letter in state.groupsCacheMap.keys){
      List<FriendsViewInfo> groupsViewInfoList = state.groupsCacheMap[letter] ?? [];
      Widget child = Container(
        margin: EdgeInsets.only(bottom: 50.rpx),
        child: Column(
          children: [
            //拼音分组
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 30.rpx),
              child: Text(
                letter,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14
                ),
              ),
            ),
            //用户列表
            Container(
              child: Column(
                children: buildGroupsInfo(groupsViewInfoList),
              ),
            )
          ],
        ),
      );
      list.add(child);
    }
    return list;
  }

  /*
   * @author Marinda
   * @date 2023/6/12 11:28
   * @description 构建朋友信息
   */
  List<Widget> buildGroupsInfo(List<FriendsViewInfo> friendsViewInfoList){
    List<Widget> list = [];
    for(FriendsViewInfo friendsViewInfo in friendsViewInfoList){
      Group group = friendsViewInfo.element ?? Group();
      int groupId = group.id ?? -1;
      //用户信息
      Widget widget = InkWell(
        child: Container(
          margin: EdgeInsets.only(bottom: 50.rpx),
          child: Row(
            children: [
              //头像
              Container(
                width: 150.rpx,
                height: 150.rpx,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10000),
                    image: DecorationImage(
                        image: Image
                            .network("${group.portrait}")
                            .image,
                        fit: BoxFit.fill
                    )
                ),
              ),
              //  昵称 & 设备&个签
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 30.rpx),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Container(
                            child: Text("${group.name ?? ""}", style: TextStyle(
                                color: Colors.black, fontSize: 14),
                              overflow: TextOverflow.ellipsis,)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: (){
          toChat(groupId, 2);
        },
      );
      list.add(widget);
    }
    return list;
  }

  /*
   * @author Marinda
   * @date 2023/6/12 11:28
   * @description 构建朋友信息
   */
  List<Widget> buildFriendsInfo(List<FriendsViewInfo> friendsViewInfoList){
    List<Widget> list = [];
    for(FriendsViewInfo friendsViewInfo in friendsViewInfoList){
      User user = friendsViewInfo.element ?? User();
      int uid = user.id ?? -1;
      //用户信息
      Widget widget = InkWell(
        child: Container(
          margin: EdgeInsets.only(bottom: 50.rpx),
          child: Row(
            children: [
              //头像
              Container(
                width: 150.rpx,
                height: 150.rpx,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10000),
                    image: DecorationImage(
                        image: Image
                            .network("${friendsViewInfo.element!.portrait}")
                            .image,
                        fit: BoxFit.fill
                    )
                ),
              ),
              //  昵称 & 设备&个签
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 30.rpx),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Container(
                            child: Text("${user.username ?? ""}", style: TextStyle(
                                color: Colors.black, fontSize: 14),
                              overflow: TextOverflow.ellipsis,)
                        ),
                      ),
                      //状态 & 登录设备
                      Container(
                        margin: EdgeInsets.only(top: 5.rpx),
                        child: Row(
                          children: [
                            Container(
                              child: Text("[IPhoneXR在线]${friendsViewInfo.element.signature ?? "这个人很懒，没有留下任何痕迹！"}",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: (){
          toChat(uid, ReceiverType.CONTACT.type);
        },
      );
      list.add(widget);
    }
    return list;
  }

  /*
   * @author Marinda
   * @date 2023/5/26 10:55
   * @description 前往Chat页 携带参数 id & type
   */
  void toChat(int id,int type){
    Map<String,int> args = {
      "id": id,
      "type": type
    };
    Get.toNamed("/chat",arguments: args);
  }

  @override
  void onClose() {

  }
}
