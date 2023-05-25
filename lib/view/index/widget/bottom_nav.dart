import 'package:flutter/material.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/view/index/logic.dart';
import 'package:get/get.dart';
import 'package:silentchat/view/index/state.dart';

/**
 * @author Marinda
 * @date 2023/5/25 14:36
 * @description 底部导航栏
 */
class BottomNavWidget extends StatefulWidget {
  final IndexLogic indexLogic;
  final IndexState indexState;

  BottomNavWidget(this.indexLogic, this.indexState, {super.key});


  @override
  State<StatefulWidget> createState() {
    return BottomNavState();
  }
}

class BottomNavState extends State<BottomNavWidget> {

  BottomNavState();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        color: Colors.green,
        padding: EdgeInsets.only(bottom: 30.rpx, top: 30.rpx),
        child: Row(
          children: buildBottomNav(widget.indexState.index.value),
        ),
      );
    });
  }

  /*
   * @author Marinda
   * @date 2023/5/25 14:58
   * @description 构建底部导航栏
   */
  List<Widget> buildBottomNav(int index) {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      Widget child = Expanded(
          child: InkWell(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    width: 100.rpx,
                    height: 100.rpx,
                    child: index == i ? Image.asset(
                        "assets/logo.jpg", color: Colors.blue) : Image.asset(
                        "assets/logo.jpg"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.rpx),
                    child: Text(getNavName(i), style: TextStyle(
                        color: index == i ? Colors.blue : Colors.white,
                        fontSize: 16)),
                  )
                ],
              ),
            ),
            onTap: () {
              widget.indexLogic.changeNavView(i);
            },
          ));
      list.add(child);
    }
    return list;
  }

  /*
   * @author Marinda
   * @date 2023/5/25 15:01
   * @description 获取导航栏名称
   */
  String getNavName(int index) {
    String result = "";
    switch (index) {
      case 0:
        result = "消息";
        break;
      case 1:
        result = "联系人";
        break;
      case 2:
        result = "动态";
        break;
    }
    return result;
  }

}