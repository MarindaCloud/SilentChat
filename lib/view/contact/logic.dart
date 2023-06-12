import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/entity/user.dart';
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


  @override
  void onInit() {
    Log.i("联系人初始化完毕！");
    initFriendsInfo();
  }

  /*
   * @author Marinda
   * @date 2023/6/12 11:02
   * @description 初始化朋友信息
   */
  void initFriendsInfo(){
    List<User> userList = systemState.friendUserList;
    Map<String,List<User>> cacheFriendUserMap = {};
    //默认字母排序为A-Z，所以还需要对用户信息做一个字母Map缓存排序
    for(int i = 0;i<state.letterList.length;i++){
      var letter = state.letterList[i];
      print('当前字母：${letter}');
      for(User user in userList){
        String userName = user.userName??"";
        //首字母转大写
        String firstLetter = PinyinHelper.getShortPinyin(userName.substring(0,1)).toUpperCase();
        if(firstLetter == letter){
          //如果不存在这个字母
          if(!cacheFriendUserMap.containsKey(letter)) {
            cacheFriendUserMap[letter] = [user];
            break;
          }else{
            List<User> cacheUserList = cacheFriendUserMap[letter] ?? [];
            List<User> newList = [];
            newList.addAll(cacheUserList);
            newList.add(user);
            cacheFriendUserMap[letter] = newList;
            break;
          }
        }
      }
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
      List<User> userList = state.friendsCacheMap[letter] ?? [];
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
                children: buildFriendsInfo(userList),
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
  List<Widget> buildFriendsInfo(List<User> userList){
    List<Widget> list = [];
    for(User user in userList){
      //用户信息
      Widget widget = Container(
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
                          child: Text("${user.userName ?? ""}", style: TextStyle(
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
      );
      list.add(widget);
    }
    return list;
  }

  @override
  void onClose() {

  }
}
