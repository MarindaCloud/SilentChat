import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/space_dynamic.dart';
import 'package:silentchat/entity/space_dynamic_info_view.dart';
import 'package:silentchat/entity/space_dynamic_view.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/util/date_time_util.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'state.dart';

class SpaceLogic extends GetxController {
  final SpaceState state = SpaceState();
  final userLogic = Get.find<UserLogic>();
  final userState = Get.find<UserLogic>().state;

  @override
  void onInit() {
    initSpaceInfo();
    // TODO: implement onInit
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/8/18 16:29
   * @description 初始化空间动态详情
   */
  void initSpaceInfo() async{
    User user = await userLogic.selectByUid(3);
    User user2 = await userLogic.selectByUid(10);
    SpaceDynamic spaceDynamic = SpaceDynamic(id: 1,uid: 3,content: "人不行别怪路不平",device: "IPhone6 Plus",time: DateTimeUtil.formatDateTime(DateTime.now(),format: DateTimeUtil.ymdhn),type: 1);
    List<String> imgList = ["http://175.24.177.189:8080/assets/cb7936ec-a02d-48ac-ad46-f1782d53d4e1.png","http://175.24.177.189:8080/assets/cb7936ec-a02d-48ac-ad46-f1782d53d4e1.png"];
    SpaceDynamic spaceDynamic2 = SpaceDynamic(id: 2,uid: 5,content: json.encode(imgList),device: "IPhone13 Pro Max",time: DateTimeUtil.formatDateTime(DateTime.now(),format: DateTimeUtil.ymdhn),type: 2);
    List<User> likeUserList = [];
    for(var i = 1;i<=4;i++){
     likeUserList.add(await userLogic.selectByUid(i));
    }
    SpaceDynamicInfoView infoView = SpaceDynamicInfoView(spaceDynamic,likeUserList);
    SpaceDynamicInfoView infoView2 = SpaceDynamicInfoView(spaceDynamic2,likeUserList);
    SpaceDynamicView dynamicView = SpaceDynamicView(user: user,viewInfo: infoView);
    SpaceDynamicView dynamicView2 = SpaceDynamicView(user: user2,viewInfo: infoView2);
    state.dynamicViewInfoList.add(dynamicView);
    state.dynamicViewInfoList.add(dynamicView2);
  }


  /*
   * @author Marinda
   * @date 2023/8/31 16:27
   * @description 构建空间动态列表
   */
  buildSpaceDynamicList() {
    return state.dynamicViewInfoList.map((element){
      User user = element.user ?? User();
      SpaceDynamicInfoView dynamicInfoView = element.viewInfo!;
      int dynamicType = dynamicInfoView.element?.type ?? 0;
      //动态
      return Container(
          width: Get.width,
          margin: EdgeInsets.only(bottom: 300.rpx),
          padding: EdgeInsets.only(left: 20.rpx,right: 10.rpx),
          child: Column(
            children: [
              //  用户详情
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.rpx),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            width: 200.rpx,
                            height: 200.rpx,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10000),
                                image: DecorationImage(
                                    image: Image.network(
                                        "${user.portrait}")
                                        .image,
                                    fit: BoxFit.fill)),
                            margin: EdgeInsets.only(right: 50.rpx),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                  EdgeInsets.only(bottom: 10.rpx),
                                  child: Text(
                                    "${user.username}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "${parseDynamicDateTime(dynamicInfoView)}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14),
                                    textAlign: TextAlign.start,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) {
                        return <PopupMenuEntry<String>>[
                          PopupMenuItem(
                            child: Text("编辑",
                                style: TextStyle(fontSize: 14)),
                            value: "编辑",
                            onTap: () {
                              print("编辑");
                            },
                          ),
                          PopupMenuItem(
                            child: Text("删除",
                                style: TextStyle(fontSize: 14)),
                            value: "编辑",
                            onTap: () {
                              print("编辑");
                            },
                          ),
                        ];
                      },
                      icon: SizedBox(
                        width: 150.rpx,
                        height: 150.rpx,
                        child: Image.asset(
                          "assets/icon/gengduo.png",
                          fit: BoxFit.fill,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //内容
              Container(
                margin: EdgeInsets.only(top: 50.rpx),
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildContentWidget(dynamicInfoView.element!) is List ? buildContentWidget(dynamicInfoView.element!) : [
                    buildContentWidget(dynamicInfoView.element!)
                  ],
                ),
              ),
              //  图标组
              Container(
                margin: EdgeInsets.only(right: 50.rpx,top: dynamicType == 1 ? 0 : 30.rpx,bottom: 30.rpx),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 80.rpx),
                      child: InkWell(
                        child: SizedBox(
                          width: 130.rpx,
                          height: 130.rpx,
                          child: Image.asset("assets/icon/good.png",
                              fit: BoxFit.fill),
                        ),
                        onTap: () {
                          print("点赞");
                        },
                      ),
                    ),
                    InkWell(
                      child: SizedBox(
                        width: 130.rpx,
                        height: 130.rpx,
                        child: Image.asset(
                          "assets/icon/xiaoxiqipao.png",
                          fit: BoxFit.fill,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        print("评论");
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.rpx,right: 0.rpx),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 50.rpx),
                      child: InkWell(
                        child: SizedBox(
                          width: 80.rpx,
                          height: 80.rpx,
                          child: Image.asset(
                            "assets/icon/good.png",
                            fit: BoxFit.fill,
                            color: Colors.blue,
                          ),
                        ),
                        onTap: (){
                          print("打开点赞列表");
                        },
                      ),
                    ),
                    Expanded(
                      child: buildCommentLikeList(dynamicInfoView.commentLikeUserList ?? [])
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.rpx,left: 10.rpx),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.rpx),
                      width: 120.rpx,
                      height: 120.rpx,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10000),
                          image: DecorationImage(
                              image: Image.network("http://175.24.177.189:8080/assets/cb7936ec-a02d-48ac-ad46-f1782d53d4e1.png").image,
                              fit: BoxFit.fill
                          )
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                          height: 150.rpx,
                          child: TextField(
                            decoration: InputDecoration(
                                fillColor: Color.fromRGBO(246,246,246,1),
                                filled: true,
                                contentPadding: EdgeInsets.only(top: 20.rpx,bottom: 20.rpx,left: 20.rpx,right: 20.rpx),
                                hintText: "说点什么吧...",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                ),
                                hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
                            ),
                            style: TextStyle(color: Colors.grey,fontSize: 14),
                          ),
                        )
                    )
                  ],
                ),
              )
            ],
          ),
        );
    }).toList();
  }

  /*
   * @author Marinda
   * @date 2023/8/31 16:38
   * @description 转化动态日期
   */
  String parseDynamicDateTime(SpaceDynamicInfoView spaceDynamicView){
    String dt = spaceDynamicView.element?.time ?? "";
    DateTime targetTime = DateTime.parse(dt);
    DateTime nowDateTime = DateTime.now();
    Duration duration = nowDateTime.difference(targetTime);
    //如果时差天数大于等于7天则时间显示为年月日时分
    if(duration.inDays >=7){
      return DateTimeUtil.formatDateTime(targetTime,format: DateTimeUtil.ymdhn);
    }else if(duration.inDays < 7 && duration.inDays >=3){
    //  如果时差天数小于7并且大于=3则显示为星期几 时分
      return DateTimeUtil.formatWeekDateTime(targetTime);
    }else if(duration.inDays <=0){
    //  显示当天
      return "今天 ${DateTimeUtil.formatDateTime(targetTime,format: DateTimeUtil.hn)}";
    }
    return "";
  }

  /*
   * @author Marinda
   * @date 2023/8/31 17:13
   * @description 构建内容控件
   */
  buildContentWidget(SpaceDynamic spaceDynamic){
    int type = spaceDynamic.type ?? 0;
    String content = spaceDynamic.content ?? "";
    dynamic widgetElement;
    switch(type){
      case 1:
        widgetElement = Expanded(
          child: Wrap(
            children: [
              Container(
                child: Text(
                  "${content}",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                  ),
                  overflow: TextOverflow.visible,
                )
              ),
            ],
          ),
        );
        //文本
        break;
      case 2:
        var jsonList = json.decode(content);
        List<Widget> widgetList = [];
        if(jsonList is List){
          for(var i = 0 ;i<jsonList.length;i++){
            var imgElement = jsonList[i];
            var imgWidget = Expanded(
              child: Container(
                margin: EdgeInsets.only(right: i == 0 ? 10.rpx : 0),
                height: 700.rpx,
                child: Image.network(
                  "${imgElement}",
                  fit: BoxFit.fill,
                ),
              ),
            );
            widgetList.add(imgWidget);
          }
        }
        widgetElement = widgetList;
        //图片
        break;
    }
    return widgetElement;
  }

  /*
   * @author Marinda
   * @date 2023/8/31 18:11
   * @description 构建点赞者列表
   */
  Widget buildCommentLikeList(List<User> commentLikeUserList) {
    int len = commentLikeUserList.length;
    List<Widget> list = [];
    List<TextSpan> textSpanList = [];
    if(commentLikeUserList.length >=3){
      for(var i = 0;i<3;i++){
        var user = commentLikeUserList[i];
        String userName = user.username ?? "";
        var textSpan = TextSpan(
            text: "${userName}${i == 2 ? "" : "、"}",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 14
            ),
            recognizer: TapGestureRecognizer(
            )..onTap = (){
              print("进入${userName}");}
        );
        textSpanList.add(textSpan);
      }
      //追加结尾
      textSpanList.add(                              TextSpan(
        text: "等${(len - 3)}个人觉得很赞",
        style: TextStyle(
            color: Colors.black,
            fontSize: 16
        ),
      ),);
    }else{
      for(var i = 0;i<3;i++){
        var user = commentLikeUserList[i];
        String userName = user.username ?? "";
        var textSpan = TextSpan(
            text: userName,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14
            ),
            recognizer: TapGestureRecognizer(
            )..onTap = (){
              print("进入${userName}");}
        );
        textSpanList.add(textSpan);
      }
    }
    return Text.rich(
        TextSpan(
          children: textSpanList,
    ),
      maxLines: 3,
      overflow: TextOverflow.clip
    );
  }

}
