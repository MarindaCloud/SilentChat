import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/logic/cache_image_handle.dart';
import 'package:silentchat/controller/system/logic.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/db/dao/cache_record_message_dao.dart';
import 'package:silentchat/db/db_manager.dart';
import 'package:silentchat/entity/account_history.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/message/view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'state.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flukit/flukit.dart';


class LoginLogic extends GetxController {
  final LoginState state = LoginState();
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;
  final systemLogic = Get.find<SystemLogic>();
  final systemState = Get.find<SystemLogic>().state;

  final storage = GetStorage();

  @override
  void onInit() async{
    await test();
    getDeviceName();
    await systemLogic.initImageCache();
    initAccountHistory();
    initPortraitType();
    // TODO: implement onInit
    super.onInit();
  }


  @override
  void dispose() {
    systemState.showHistory.value = false;
    super.dispose();
  }

  test() async{
  }

  /*
   * @author Marinda
   * @date 2023/9/11 10:59
   * @description 初始化
   */
  initPortraitType(){
    String userName = state.userName.text;
    var historyList = state.accountHistoryList;
    var element = historyList.firstWhereOrNull((element) =>
    element.username == userName);
    if (element != null) {
        String portrait = element.portrait ?? "";
        if (CacheImageHandle.containsImageCache(portrait)) {
          state.type.value = 1;
        }
    }else{
      state.type.value = 0;
    }
    Log.i("type: ${state.type.value}");
  }

  /*
   * @author Marinda
   * @date 2023/9/11 10:36
   * @description 构建头像
   */
  buildPortrait(){
    String userName = state.userName.text;
    var historyList = state.accountHistoryList;
    if(state.type.value == 1) {
      var element = historyList.firstWhereOrNull((element) =>
      element.username == userName);
      if (element != null) {
        String portrait = element.portrait ?? "";
        return userLogic.buildPortraitWidget(1,portrait);
      }
    }else{
      return Image.asset("assets/user/portait.png");
    }
  }

  /*
   * @author Marinda
   * @date 2023/11/20 17:24
   * @description 跳转至忘记密码页
   */
  toForgotPassword() async{
    await Get.toNamed(AppPage.forgotPwd);
  }

  /*
   * @author Marinda
   * @date 2023/9/11 10:48
   * @description 文本修改控制器
   */
  onTextUpdate(String value){
    initPortraitType();
  }

  /*
   * @author Marinda
   * @date 2023/9/1 16:50
   * @description 初始化账号历史
   */
  initAccountHistory(){
    //账号
    if(storage.read("account") != null){
      var account = storage.read("account");
      var element = json.decode(account);
      if(element is List){
        List<AccountHistory> accountHistoryList = element.map((e) => AccountHistory.fromJson(e)).toList();
        state.accountHistoryList.value = accountHistoryList;
      }
    }
    Log.i("初始化历史账号信息：${state.accountHistoryList.map((element) => element.toJson()).toList()}");
  }

  /*
   * @author Marinda
   * @date 2023/5/25 14:49
   * @description 跳转至index页
   */
  void toIndex(){
    Get.offNamed(AppPage.index);
  }

  /*
   * @author Marinda
   * @date 2023/8/15 10:26
   * @description 获取设备名称
   */
  void getDeviceName() async{
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String deviceName = "";
    if(GetPlatform.isAndroid){
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      deviceName = androidDeviceInfo.model;
    }else{
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      deviceName = iosDeviceInfo.name;
    }
    userState.deviceName = deviceName;
    Log.i("设备名称: ${deviceName}");
  }

  /*
   * @author Marinda
   * @date 2023/9/1 18:01
   * @description 移除账号历史记录
   */
  removeAccountHistory(AccountHistory accountHistory) async{
    var accountHistoryValue = storage.read("account");
    var value = json.decode(accountHistoryValue);
    if(value is List){
      List<AccountHistory> accountHistoryList = value.map((e) => AccountHistory.fromJson(e)).toList();
      int index = accountHistoryList.indexWhere((element) => element.username == accountHistory.username);
      if(index != -1){
        accountHistoryList.removeAt(index);
        await storage.write("account", json.encode(accountHistoryList));
        state.accountHistoryList.removeAt(index);
        Log.i("移除账号：${accountHistory.username}历史记录");
      }
      state.accountHistoryList.refresh();
    }
  }

  /*
   * @author Marinda
   * @date 2023/9/1 16:45
   * @description 构建历史账号组件
   */
   buildHistoryWidget(){
     double dy = state.layout?.offset.dy ?? 0;
     double left = state.layout?.offset.dx ?? 0 + 250.rpx;
     Size size = state.layout?.size ?? Size(0, 0);
     var top =((Get.width - size.height) /2);
    return Positioned(
      left: left,
      top: top + 330.rpx,
      child: Visibility(
          visible: systemState.showHistory.value,
          child: Container(
            padding: EdgeInsets.only(left: 30.rpx,
                right: 0.rpx,
                top: 0.rpx,
                bottom: 0.rpx),
            decoration: BoxDecoration(
                color: Color.fromRGBO(242, 243, 246, 1).withOpacity(.3),
                // borderRadius: BorderRadius.circular(100000)
            ),
            width: size.width,
            child: ListView.builder(itemBuilder: (context,index){
              var element = state.accountHistoryList[index];
              return InkWell(
                child: Container(
                  height: 200.rpx,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                            "${element.username}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      //移除历史账号
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.close_outlined),
                          onPressed: () { removeAccountHistory(element); },
                          color: Colors.grey,
                        )
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  state.userName.text = element.username??"";
                  state.passWord.text = element.password ?? "";
                  Log.i("已切换：${element.username}账号信息");
                  state.type.refresh();
                },
              );
            },shrinkWrap: true,itemCount: state.accountHistoryList.length),
          ),
      ),
    );
  }

  /*
   * @author Marinda
   * @date 2023/9/1 17:18
   * @description 用户名组件布局信息
   */
  userNameReaderLayoutInfo(RenderAfterLayout ral){
     state.layout = ral;
  }

  /*
   * @author Marinda
   * @date 2023/6/8 16:01
   * @description 登录接口
   */
  void login() async{
    String userName = state.userName.text;
    String passWord = state.passWord.text;
    APIResult apiResult = await UserAPI.login(userName, passWord);

    if(apiResult.code == 400){
      BotToast.showText(text: "登录失败，账号或密码错误");
      return;
    }
    User user = User.fromJson(apiResult.data["user"]);
    userState.uid.value = user?.id ?? -1;
    userState.user.value = user;
    List<AccountHistory> accountList = [];
    AccountHistory accountHistory = AccountHistory(username: userName,password: passWord,portrait: user.portrait ?? "");
    if(storage.read("account") == null){
      accountList.add(accountHistory);
    }else{
      var accountHistoryStorage = storage.read("account");
      var data = json.decode(accountHistoryStorage);
      if(data is List){
        accountList = data.map((e) => AccountHistory.fromJson(e)).toList();
        int index = accountList.indexWhere((element) => element.username == userName);
        if(index == -1){
          accountList.add(accountHistory);
        }
      }
    }
    //加载全局缓存
    await systemLogic.loadGlobalImageCache(userState.user.value);
    await storage.write("account", json.encode(accountList));
    Log.i("账号历史记录：${accountList.map((e) => e.toJson()).toList()}");
    Log.i("用户信息：${user.toJson()}");
    toIndex();
    Log.i("登录响应结果: ${apiResult}");
  }

}
