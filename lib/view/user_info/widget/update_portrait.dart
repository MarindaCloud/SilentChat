import 'package:flutter/material.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/user_info/logic.dart';
import 'package:silentchat/view/user_info/state.dart';
import 'package:get/get.dart';

/**
 * @author Marinda
 * @date 2023/7/7 14:05
 * @description 修改头像组件
 */
class UpdatePortraitComponent extends StatefulWidget {
  final UserInfoLogic userInfoLogic;
  final UserInfoState userInfoState;

  UpdatePortraitComponent(this.userInfoLogic, this.userInfoState);


  @override
  State<StatefulWidget> createState() {
    return UpdatePortraitState();
  }

}


class UpdatePortraitState extends State<UpdatePortraitComponent>
    with SingleTickerProviderStateMixin {

  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController!);

    animationController!.addStatusListener((status) {
      if (status == animationController!.isCompleted) {
        animationController!.reset();
      }
    });
    animationController!.forward();
  }


  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Center(
        child: AnimatedOpacity(
          opacity: animation!.value,
          duration: Duration(seconds: 1),
          child: Container(
            padding: EdgeInsets.all(10),
            width: 1200.rpx,
            height: 800.rpx,
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(267, 267, 267, 1)),
              color: Colors.black.withOpacity(0.3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: getImageProvider(),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    onTap: () {
                      // widget.userInfoLogic.pickPortrait();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  /*
   * @author Marinda
   * @date 2023/7/7 18:18
   * @description 获取图片适配器
   */
  ImageProvider getImageProvider() {
    User user = widget.userInfoLogic.userState.user.value;
    //如果为空则设定默认头像
    if (user.portrait == null || user.portrait == "") {
      widget.userInfoState.portrait.value = "assets/user/portait.png";
      return Image
          .asset(widget.userInfoState.portrait.value)
          .image;
    }
    return Image
        .network(user.portrait ?? "")
        .image;
  }

}
