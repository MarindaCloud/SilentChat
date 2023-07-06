import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/friends_view_info.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/enum/receiver_type.dart';
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
  }



  /*
   * @author Marinda
   * @date 2023/7/4 15:16
   * @description 跳转至朋友验证消息
   */
  toFriendsVerify(){
    Map<String,dynamic> args = {
      "type": 1
    };
    Get.toNamed(AppPage.verify,arguments: args);
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
      FriendsViewInfo friendsViewInfo = FriendsViewInfo(user: user);
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
      // for(User user in userList){
      //   String username = user.username??"";
      //   //首字母转大写
      //   String firstLetter = PinyinHelper.getShortPinyin(username.substring(0,1)).toUpperCase();
      //   if(firstLetter == letter){
      //     //如果不存在这个字母
      //     if(!cacheFriendUserMap.containsKey(letter)) {
      //       cacheFriendUserMap[letter] = [user];
      //       break;
      //     }else{
      //       List<User> cacheUserList = cacheFriendUserMap[letter] ?? [];
      //       List<User> newList = [];
      //       newList.addAll(cacheUserList);
      //       newList.add(user);
      //       cacheFriendUserMap[letter] = newList;
      //       Log.i("newList: ${newList.map((e) => e.toJson()).toList()}");
      //       break;
      //     }
      //   }
      // }
    }
    state.friendsCacheMap.value = cacheFriendUserMap;
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
   * @date 2023/6/12 11:28
   * @description 构建朋友信息
   */
  List<Widget> buildFriendsInfo(List<FriendsViewInfo> friendsViewInfoList){
    List<Widget> list = [];
    for(FriendsViewInfo friendsViewInfo in friendsViewInfoList){
      User user = friendsViewInfo.user ?? User();
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
                            .asset("assets/user/portait.png")
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
                              child: Text("[IPhoneXR]在线个性签名",
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
