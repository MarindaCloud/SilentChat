import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/input_box.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/group_announcement.dart';
import 'package:silentchat/entity/group_user_info.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/group_announcement_api.dart';
import 'package:silentchat/network/api/group_api.dart';
import 'package:silentchat/network/api/group_info_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/util/overlay_manager.dart';
import 'state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:bot_toast/bot_toast.dart';

/**
 * @author Marinda
 * @date 2023/9/18 10:45
 * @description 编辑群组信息
 */
class EditGroupInfoLogic extends GetxController {
  final EditGroupInfoState state = EditGroupInfoState();
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;

  @override
  void onInit() {
    state.group.value = Get.arguments;
    initGroupUserInfo();
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/10/8 11:21
   * @description 初始化群用户详情信息
   */
  initGroupUserInfo() async{
    List<GroupUserInfo> list = await GroupInfoAPI.selectByGid(state.group.value.id!);
    List<int> userIdList = list.map((e) => e.uid ?? -1).toList();
    List<User> userList = [];
    for(var id in userIdList){
      User user = await UserAPI.selectByUid(id);
      userList.add(user);
    }
    state.userList.value = userList;
    state.userInfoList.value = list;
    List<GroupAnnouncement> announcementList = await GroupAnnouncementAPI.selectByGid(state.group.value.id!);
    announcementList.sort((a,b)=>b.time!.compareTo(a.time!));
    state.groupAnnouncementList.value = announcementList;
    GroupAnnouncement announcement = state.groupAnnouncementList.firstWhereOrNull((element) => element.isTop == 1) ?? GroupAnnouncement(content: "暂无");
    state.newAnnounment.value = announcement.content ?? "";
    int uid = userState.uid.value;
    GroupUserInfo target = state.userInfoList.firstWhereOrNull((element) => element.gid == state.group.value!.id && element.uid == uid) ?? GroupUserInfo();
    state.nickName.value = target.nickName ?? "";
    bool flag = await validGroupAdminIdentity();
    state.validAdminIdentity.value = flag;
    Log.i("是否是管理员：${flag}");
    Log.i("群员总计: ${state.userList.length}");
    Log.i("群公告总计: ${state.groupAnnouncementList.length}");
  }

  close(){
    Get.back();
  }


  /*
   * @author Marinda
   * @date 2023/10/8 11:38
   * @description 构建群统计
   */
  buildGroupChart(){
    var list = state.userList.value;
    //获取性别为男的总数
    int manCount = list.where((element) => element.sex == 1).toList().length;
    int womanCount = list.where((element) => element.sex == 2).toList().length;
    return BarChart(
      BarChartData(
          maxY: state.group.value.personMax!.toDouble(),
          minY: 0,
          gridData:  FlGridData(show: false),
          titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
              ),
              rightTitles: AxisTitles(
              ),
              leftTitles: AxisTitles(
              ),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      // reservedSize: ,
                      getTitlesWidget: (value,meta){
                        String text = "";
                        switch(value.toInt()){
                          case 0:
                            text = "男女比例";
                            break;
                        }
                        return SideTitleWidget(
                          child: Text(
                            text,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14
                            ),
                          ),
                          axisSide: meta.axisSide,
                          space: 4,
                        );
                      }
                  )
              )
          ),
          backgroundColor: Color.fromRGBO(46,66,97,1),
          barGroups: [
            BarChartGroupData(
                x: 0,
                barsSpace: 2,
                barRods: [
                  BarChartRodData(
                      fromY: 0,
                      toY: manCount.toDouble(),
                      color: Colors.orange
                  ),
                  BarChartRodData(
                      fromY: 0,
                      toY: womanCount.toDouble(),
                      color: Colors.pink
                  )
                ]),
            // BarChartGroupData(x: 70)
          ]
      ),
      swapAnimationCurve: Curves.ease,
      swapAnimationDuration: Duration(milliseconds: 150),
    );
  }

  /*
   * @author Marinda
   * @date 2023/9/18 15:57
   * @description 构建群员头像
   */
  buildGroupStaff(){
    double maxWidth = 0;
    List<Widget> widgetList = [];
    double viewWidget = Get.width;
    for(User user in state.userList){
      //如果当前宽度大于可视的最大宽度则停止
      if(maxWidth >= viewWidget){
        break;
      }
      var staff = Container(
        width: 150.rpx,
        height: 150.rpx,
        margin: EdgeInsets.only(right: 50.rpx),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: userLogic.buildPortraitWidget(1,user.portrait!).image,
            fit: BoxFit.fill
          ),
          borderRadius: BorderRadius.circular(10000),
        ),
      );
      maxWidth += 230.rpx;
      widgetList.add(staff);
    }
    return widgetList;
  }

  /*
   * @author Marinda
   * @date 2023/9/18 15:43
   * @description 构建群组信息列表
   */
  buildGroupInfoList(){
    List<Widget> widgetList = [];
    Map<String,String> cacheMap = {
      "群简介": "detail",
      "群昵称": "yonghu",
      "群公告": "gonggao"
    };
    cacheMap.forEach((key, value) {
      Widget widget = InkWell(
        child: Container(
          margin: EdgeInsets.only(top: 50.rpx,bottom: 50.rpx),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  children: [
                    //详情
                    Container(
                      margin: EdgeInsets.only(right: 50.rpx),
                      child: SizedBox(
                        width: 80.rpx,
                        height: 80.rpx,
                        child: Image.asset("assets/icon/${value}.png",fit: BoxFit.fill,color: Colors.black,),
                      ),
                    ),
                    Container(
                      child: Text(
                        "${key}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 1000.rpx
                      ),
                      child: Container(
                        margin: EdgeInsets.only(right: 10.rpx),
                        child: Text(
                          "${getGroupBasicInfoText(key)}",
                          style: TextStyle(
                              color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: null,
                        ),
                      ),
                    ),
                    Container(
                      child: SizedBox(
                        width: 80.rpx,
                        height: 80.rpx,
                        child: Image.asset("assets/icon/qianwang.png",fit: BoxFit.fill),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: ()=>showHelperView(key),
      );
      widgetList.add(widget);
    });
    return widgetList;
  }

  /*
   * @author Marinda
   * @date 2023/10/8 14:04
   * @description 获取群组基础信息文本
   */
  String getGroupBasicInfoText(String key){
    Group group = state.group.value;
    String text = "";
      switch(key){
        case "群简介":
          text = group.description ?? "";
          break;
        case "群昵称":
          text = state.nickName.value;
          break;
        case "群公告":
          text = state.newAnnounment.value;
          break;
      }
      return text;
  }

  /*
   * @author Marinda
   * @date 2023/11/16 16:49
   * @description 校验当前用户是否是群聊管理员
   */
  Future<bool> validGroupAdminIdentity() async{
    int gid = state.group.value.id ?? 0;
    int uid = userState.uid.value;
    List<GroupUserInfo> list = await GroupInfoAPI.selectByGid(gid);
    var element = list.firstWhereOrNull((element) => element.uid == uid && element.isAdmin == 1);
    return element!=null;
  }

  /*
   * @author Marinda
   * @date 2023/10/9 14:29
   * @description 根据群聊基础Key显示相关帮助组件视图
   */
  showHelperView(String key) {
    switch(key){
      case "群简介":
        OverlayManager().createOverlay("inputBox",InputBoxComponent("更改群简介",state.group.value.description!,(controller){handleCustomContent(key, controller.text);}));
        break;
      case "群昵称":
        GroupUserInfo target = state.userInfoList.firstWhere((element) => element.gid == state.group.value.id);
        state.userInfoList.forEach((element) {
          print('element: ${element.toJson()}');
        });
        OverlayManager().createOverlay("inputBox",InputBoxComponent("更改群昵称",target.nickName!,(controller){handleCustomContent(key, controller.text);}));
        break;
      case "群公告":
        toGroupAnnouncement();
        break;
      case "群名称":
        OverlayManager().createOverlay("inputBox",InputBoxComponent("更改群简介",state.group.value.name!,(controller){handleCustomContent(key, controller.text);}));
        break;
    }
  }

  /*
   * @author Marinda
   * @date 2023/10/9 17:49
   * @description 跳转至群公告
   */
  toGroupAnnouncement() async{
    Map<String,dynamic> args = {
      "group": state.group.value,
      "list": state.groupAnnouncementList.value,
      "isAdmin": state.validAdminIdentity.value
    };
    await Get.toNamed(AppPage.groupAnnouncement,arguments: args);
    initGroupUserInfo();
  }

  /*
   * @author Marinda
   * @date 2023/10/9 14:35
   * @description 处理自定义内容
   */
  handleCustomContent(String key,String text) async{
    Group group = state.group.value;
    int result = 0;
    switch(key){
      case "群简介":
        group.description = text;
        result = await GroupAPI.updateGroupInfo(group);
        BotToast.showText(text: "${result >0 ? "更改成功！":  "更改失败！"}");
        break;
      case "群昵称":
        GroupUserInfo groupUserInfo = state.userInfoList.first;
        groupUserInfo.nickName = text;
        result = await GroupInfoAPI.update(groupUserInfo);
        BotToast.showText(text: "${result >0 ? "更改成功！": "更改失败！"}");
        break;
      case "群名称":
        group.name = text;
        result = await GroupAPI.updateGroupInfo(group);
        BotToast.showText(text: "${result >0 ? "更改成功！":  "更改失败！"}");
        break;
    }
  }
}
