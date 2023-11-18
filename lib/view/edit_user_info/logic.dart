import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:lunar/lunar.dart';
import 'state.dart';

import 'package:bot_toast/bot_toast.dart';
/**
 * @author Marinda
 * @date 2023/11/16 17:27
 * @description 编辑用户信息Logic
 */
class EditUserInfoLogic extends GetxController {
  final EditUserInfoState state = EditUserInfoState();
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;


  @override
  void onInit() {
    initBirthBasicInfo();
    loadUserInfo();
    // TODO: implement onInit
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/11/18 15:43
   * @description 加载用户信息
   */
  loadUserInfo() {
    User user = userState.user.value;
    state.userNameController.text = user.username!;
    state.signatureController.text = user.signature ?? "";
    state.emailController.text = user.email ?? "";
    state.locationController.text = user.location ?? "";
    state.sex.value = user.sex == 1 ? "男" : "女";
    DateTime birthDay = user.birthday ?? DateTime.now();
    state.year.value = birthDay.year.toString();
    state.month.value = birthDay.month.toString();
    state.day.value = birthDay.day.toString();
  }

  initBirthBasicInfo() {
    DateTime dt = DateTime.now();
    List<int> years = [];
    List<int> months = [];
    List<int> days = [];
    int max = dt.year;
    int min = 1970;
    for (int i = min; i <= max; i++) {
      years.add(i);
    }
    for (int i = 1; i <= 12; i++) {
      months.add(i);
    }
    for (int i = 1; i <= 31; i++) {
      days.add(i);
    }
    state.years = years;
    state.months = months;
    state.days.value = days;
    state.year.value = state.years.first.toString();
    state.month.value = state.months.first.toString();
    state.day.value = state.days.first.toString();
  }

  /*
   * @author Marinda
   * @date 2023/11/17 13:54
   * @description 选择年份方法
   */
  chooseMonth(int month) {
    int year = int.parse(state.year.value);
    int month = int.parse(state.month.value);
    int days = SolarUtil.getDaysOfMonth(year, month);
    List<int> dayList = [];
    for (int i = 1; i <= days; i++) {
      dayList.add(i);
    }
    state.days.value = dayList;
    state.day.value = state.days.first.toString();
  }

  /*
   * @author Marinda
   * @date 2023/11/17 11:02
   * @description 构建文本框详情空间
   */
  Widget buildEditInfo(String title, TextEditingController controller,[bool isFirst = false]) {
    return Container(
      width: Get.width,
      height: 200.rpx,
      margin: EdgeInsets.only(left: 50.rpx, right: 50.rpx, bottom: isFirst ? 30.rpx : 80.rpx),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //label
          Container(
            margin: EdgeInsets.only(right: 100.rpx),
            child: Text(
              "${title}：",
              style: TextStyle(
                  color: Colors.black, fontSize: 16, letterSpacing: 2),
            ),
          ),
          Expanded(
              child: Container(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: "请输入文本信息...",
                  contentPadding: EdgeInsets.all(50.rpx),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ))),
              maxLines: 1,
              maxLength: null,
            ),
          ))
        ],
      ),
    );
  }

  /*
   * @author Marinda
   * @date 2023/11/17 11:03
   * @description 构建性别选择Widget
   */
  Widget buildSexWidget() {
    return Container(
      margin: EdgeInsets.only(left: 50.rpx, right: 50.rpx),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //label
          Container(
            margin: EdgeInsets.only(right: 100.rpx),
            child: Text(
              "性别：",
              style: TextStyle(
                  color: Colors.black, fontSize: 16, letterSpacing: 5),
            ),
          ),
          Expanded(
              child: Container(
            child: Row(
              children: [
                Container(
                    child: Radio<String>(
                  groupValue: state.sex.value,
                  value: "男",
                  onChanged: (value) {
                    state.sex.value = value!;
                    print("选中情况：${value}");
                  },
                )),
                Container(
                  child: Text(
                    "男",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                Container(
                    child: Radio<String>(
                  groupValue: state.sex.value,
                  value: "女",
                  onChanged: (value) {
                    state.sex.value = value!;
                    print("选中情况：${value}");
                  },
                )),
                Container(
                  child: Text(
                    "女",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  /*
   * @author Marinda
   * @date 2023/11/17 11:26
   * @description
   */
  Widget buildBirthDay() {
    return Container(
        height: 200.rpx,
        margin: EdgeInsets.only(left: 50.rpx, right: 50.rpx, bottom: 50.rpx),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //label
              Container(
                margin: EdgeInsets.only(right: 20.rpx),
                child: Text(
                  "生日：",
                  style: TextStyle(
                      color: Colors.black, fontSize: 16, letterSpacing: 5),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 20.rpx),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: state.year.value,
                                items: buildDateSelectorWidget(state.years),
                                onChanged: (String? value) {
                                    state.year.value = value ?? "";
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50.rpx),
                              child: Text(
                                "年",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 30.rpx),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 20.rpx),
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: state.month.value,
                                  items: buildDateSelectorWidget(state.months),
                                  onChanged: (String? value) {
                                    state.month.value = value ?? "";
                                    chooseMonth(int.parse(value??""));
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 50.rpx),
                                child: Text(
                                  "月",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 30.rpx),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 20.rpx),
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: state.day.value,
                                  items: buildDateSelectorWidget(state.days.value),
                                  onChanged: (String? value) {
                                    state.day.value = value ?? "";
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 50.rpx),
                                child: Text(
                                  "日",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    )
                  ],
                ),
              ),
            ]));
  }

  /*
   * @author Marinda
   * @date 2023/11/17 13:55
   * @description 构建时间选择器
   */
  buildDateSelectorWidget(List<int> list) {
    return list.map((e) {
      return DropdownMenuItem<String>(
          child: Center(
            child: Container(
        child: Text(
            "${e}",
            style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
          ),
        value: e.toString(),
      );
    }).toList();

    // int max = DateT
  }

  reset(){
    loadUserInfo();
  }


  /*
   * @author Marinda
   * @date 2023/11/18 15:52
   * @description 修改用户信息
   */
  updateUserInfo() async{
    String userName = state.userNameController.text;
    String email = state.emailController.text;
    String signature = state.signatureController.text;
    String location = state.locationController.text;
    int sex = state.sex.value == "男" ? 1 : 2;
    int year = int.parse(state.year.value);
    int month = int.parse(state.month.value);
    int day = int.parse(state.day.value);
    DateTime birthDay = DateTime(year,month,day);
    User cacheUser = userState.user.value;
    User user = User.fromJson(cacheUser.toJson());
    user.signature = signature;
    user.location = location;
    user.email = email;
    user.username = userName;
    user.sex = sex;
    user.birthday = birthDay;
    bool result = await UserAPI.updateUser(user);
    if(!result){
      BotToast.showText(text: "修改失败！");
    } else{
      BotToast.showText(text: "修改成功!");
    }
  }
}
