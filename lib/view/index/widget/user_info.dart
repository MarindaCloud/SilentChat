import 'package:flutter/material.dart';
import 'package:silentchat/common/system/state.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/index/logic.dart';
import 'package:get/get.dart';
import 'package:silentchat/view/index/state.dart';

/*
 * @author Marinda
 * @date 2023/6/12 18:24
 * @description 用户详情组件 左弹出
 */
class UserInfoWidget extends StatefulWidget {
  final IndexLogic indexLogic;
  final IndexState indexState;

  UserInfoWidget(this.indexLogic, this.indexState, {super.key});

  @override
  State<StatefulWidget> createState() {
    return UserInfoState();
  }
}

class UserInfoState extends State<UserInfoWidget> {

  @override
  void initState() {
    Log.i("初始化用户信息！");
  }

  toUserInfo(){
    Get.toNamed(AppPage.userInfo,arguments: widget.indexLogic.userState.user.value.id);
  }

  UserInfoState();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(242,242,242,1),
      child: SafeArea(
        child: Column(
          children: [
            //头部信息
            Container(
              height: 100,
              decoration: BoxDecoration(
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      width: 100,
                      height: Get.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(1000)),
                          image: DecorationImage(
                              image: Image.network(widget.indexLogic.userState.user.value.portrait ?? "",).image,
                              fit: BoxFit.fill
                          )
                      ),
                    ),
                    onTap: (){
                      toUserInfo();
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Container(
                    child: Text("用户名：${widget.indexLogic.userState.user.value.username}"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100.rpx,
            ),
            //  内容
            Expanded(
                child: Column(
                  children: buildContentList()
                )
            ),
            footNavWidget()
          ],
        ),
      ),
    );
  }

  /*
   * @author Marinda
   * @date 2023/6/19 16:46
   * @description 构建内容List
   */
  List<Widget> buildContentList(){
    List<Widget> list = [];
    List<String> navList = ["个人信息","我的钱包"];
    for(int i = 0;i<navList.length;i++){
      String icon = i == navList.length - 1 ? "assets/icon/qianbao_o.png" : "assets/icon/gerenxinxi.png";
    //  构建五个选项信息
      Widget widget = Container(
        padding: EdgeInsets.symmetric(horizontal: 50.rpx),
        height: 200.rpx,
        margin: EdgeInsets.only(bottom: 30.rpx),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey,width: 1)),
        ),
        child: Row(
          children: [
          //  icon
            SizedBox(
              width: 100.rpx,
              height: 100.rpx,
              child: Image.asset(icon,fit: BoxFit.cover,),
            ),
            SizedBox(width: 50.rpx,),
            Expanded(
                child: Text(navList[i],style: TextStyle(color: Colors.black,overflow: TextOverflow.ellipsis))
            )
          ],
        ),
      );
      list.add(widget);
    }
    return list;
  }

  /*
   * @author Marinda
   * @date 2023/6/19 16:57
   * @description 底部导航栏控件列表
   */
  Widget footNavWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.rpx),
      alignment: Alignment.center,
      height: 200.rpx,
      color: Colors.white,
      child: Row(
        children: [
          //设置
          InkWell(
            child: Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 100.rpx,
                    height: 100.rpx,
                    child: Image.asset("assets/icon/shezhi.png",fit: BoxFit.fill),
                  ),
                  SizedBox(width: 10.rpx),
                  Text("设置",style: TextStyle(fontSize: 16,letterSpacing: 3.rpx))
                ],
              ),
            ),
            onTap: (){
              //暂时当退出用
              Get.back();
              Log.i("设置！");
            },
          )
        ],
      ),
    );
  }
}
