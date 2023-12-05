import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/expansion/image_path.dart';
import 'package:silentchat/common/logic/cache_image_handle.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/space.dart';
import 'package:silentchat/entity/space_comment_view.dart';
import 'package:silentchat/entity/space_dynamic.dart';
import 'package:silentchat/entity/space_dynamic_comment.dart';
import 'package:silentchat/entity/space_dynamic_info.dart';
import 'package:silentchat/entity/space_dynamic_info_view.dart';
import 'package:silentchat/entity/space_dynamic_like.dart';
import 'package:silentchat/entity/space_dynamic_view.dart';
import 'package:silentchat/entity/space_user_info.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/network/api/space_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/util/date_time_util.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/util/overlay_manager.dart';

import 'state.dart';

/**
 * @author Marinda
 * @date 2023/11/21 15:06
 * @description 个人空间
 */
class MySpaceLogic extends GetxController {
  final MySpaceState state = MySpaceState();
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;

  @override
  void onInit() {
    var args = Get.arguments;
    state.user.value = args["user"];
    initSpaceInfo();
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/8/18 16:29
   * @description 初始化空间动态详情
   */
  void initSpaceInfo() async{
    User user = state.user.value;
    int uid = user.id ?? -1;
    SpaceUserInfo? spaceUserInfo = await SpaceAPI.selectUserSpaceByUid(uid);
    if(spaceUserInfo == null){
      Space basicSpace = Space(exp: 0,name: "${userState.user.value.username}的空间",level: 1);
      int result = await SpaceAPI.insertSpace(basicSpace);
      if(result >=1){
        SpaceUserInfo spaceUserInfo = SpaceUserInfo(uid: uid,spaceId: result);
        await SpaceAPI.insertSpaceUserInfoDynamic(spaceUserInfo);
        Log.i("创建空间成功！");
        //这里是重新调用一下自身
        initSpaceInfo();
      }
    }
    int spaceId = spaceUserInfo!.spaceId!;
    List<SpaceDynamicInfo> dynamicInfoList = await SpaceAPI.selectDynamicInfoBySid(spaceId);
    List<int> dynamicIdList = dynamicInfoList.map((e) => e.dynamicId ?? 0).toList();
    List<SpaceDynamic> dynamicList = [];
    for(var id in dynamicIdList){
      SpaceDynamic spaceDynamic = await SpaceAPI.selectDynamicById(id);
      dynamicList.add(spaceDynamic);
    }
    List<SpaceDynamicView> dynamicViewList = [];
    int index = 1;
    for(SpaceDynamic spaceDynamicElement in dynamicList){
      int dynamicId = spaceDynamicElement.id ?? -1;
      int dynamicUid = spaceDynamicElement.uid ?? -1;
      User dynamicUser = await UserAPI.selectByUid(dynamicUid);
      var spaceDynamicLikeList = await SpaceAPI.selectDynamicLikeByDid(dynamicId);
      List<User> likeUserList = [];
      //点赞列表
      if(spaceDynamicLikeList != null){
        for(var element in spaceDynamicLikeList){
          int likeUid  = element.uid ?? -1;
          User likeUser = await UserAPI.selectByUid(likeUid);
          String portrait = likeUser.portrait ?? "";
          //添加用户头像至本地缓存
          await CacheImageHandle.addImageCache(portrait);
          likeUserList.add(likeUser);
        }
      }
      //评论列表
      List<SpaceDynamicComment> commentList = await SpaceAPI.selectDynamicCommentListByDynamicId(dynamicId);
      List<SpaceCommentView> spaceCommentViewList = [];
      for(var element in commentList){
        User user = await UserAPI.selectByUid(element.uid!);
        SpaceCommentView view = SpaceCommentView(user, element);
        spaceCommentViewList.add(view);
      }
      String tag = "dynamic_${index}";
      SpaceDynamicInfoView infoView = SpaceDynamicInfoView(spaceDynamicElement,likeUserList,spaceCommentViewList);
      SpaceDynamicView dynamicView = SpaceDynamicView(user: dynamicUser,viewInfo: infoView,tag: tag);
      dynamicViewList.add(dynamicView);
      index++;
    }
    //排序
    sortDynamics(dynamicViewList);
    state.dynamicViewInfoList.value = dynamicViewList;
    downloadContentImageInfo();
  }
  
  /*
   * @author Marinda
   * @date 2023/11/28 11:24
   * @description 排序动态列表
   */
  sortDynamics(List<SpaceDynamicView> list){
    list.sort((a,b){
      int flag = 0;
      SpaceDynamic? aSpaceDynamic = a.viewInfo?.element;
      SpaceDynamic? bSpaceDynamic = b.viewInfo?.element;
      if(aSpaceDynamic != null || bSpaceDynamic != null){
        DateTime aDt = DateTime.parse(aSpaceDynamic?.time ?? "");
        DateTime bDt = DateTime.parse(bSpaceDynamic?.time ?? "");
        flag = bDt.compareTo(aDt);
      }
      return flag;
    });
  }

  //提前预下载内容图片信息
  void downloadContentImageInfo(){
    var list = state.dynamicViewInfoList.value;
    for(var element in list){
      var dynamicElement =  element.viewInfo?.element!;
      String image = dynamicElement?.image ?? "";
      if(image != "" && image != null){
        var jsonList = json.decode(image);
        if(jsonList is List){
          for(var i = 0;i<jsonList.length;i++){
            var img = jsonList[i];
            //后台下载
            CacheImageHandle.addImageCache(img);
          }
        }
      }

    }
  }

  /*
   * @author Marinda
   * @date 2023/11/28 15:45
   * @description
   */
  removeDynamic(SpaceDynamicView view) async{
    int dynamicId = view.viewInfo?.element?.id ?? -1;
    Log.i("删除动态ID: ${dynamicId}");
    int index = state.dynamicViewInfoList.indexOf(view);

    return;
    int result = await SpaceAPI.deleteSpaceDynamicById(dynamicId);
    if(result >=1){
      BotToast.showText(text: "删除成功！");
    }else{
      BotToast.showText(text: "删除失败！");
    }
  }

  /*
   * @author Marinda
   * @date 2023/11/21 15:48
   * @description 跳转至发布动态页
   */
  toReleaseDynamicPage() async{
    await Get.toNamed(AppPage.releaseSpaceDynamic);
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
      // int dynamicType = dynamicInfoView.element?.type ?? 0;
      List<User> dynamicUserList = dynamicInfoView.commentLikeUserList ?? [];
      TextEditingController controller = TextEditingController(text: "");
      //动态
      return Container(
        width: Get.width,
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 80.rpx),
        padding: EdgeInsets.only(left: 20.rpx,right: 10.rpx,bottom: 50.rpx,top: 50.rpx),
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
                                  image: userLogic.buildPortraitWidget(1,user.portrait ?? "")
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
                            Get.toNamed(AppPage.releaseSpaceDynamic,arguments: dynamicInfoView.element!);
                          },
                        ),
                        PopupMenuItem(
                          child: Text("删除",
                              style: TextStyle(fontSize: 14)),
                          value: "删除",
                          onTap: () {
                            removeDynamic(element);
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
                      ) ,
                    ),
                  )
                ],
              ),
            ),
            //构建内容
            Container(
              margin: EdgeInsets.only(top: 50.rpx,bottom: 30.rpx),
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildContentWidget(dynamicInfoView.element!),
                  //构建图像
                  Container(
                    margin: EdgeInsets.only(top: 50.rpx),
                    padding: EdgeInsets.only(left: 0,right: 10),
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        ...buildImageWidget(dynamicInfoView.element!)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //  图标组
            Container(
              margin: EdgeInsets.only(bottom: 30.rpx),
              padding: EdgeInsets.only(left: 10.rpx),
              // margin: EdgeInsets.only(right: 50.rpx,top: dynamicType == 1 ? 0 : 30.rpx,bottom: 30.rpx),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //设备名称
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20.rpx),
                          child: SizedBox(
                            width: 80.rpx,
                            height: 80.rpx,
                            child: Image.asset(
                                "iphone.png".icon,
                                fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${dynamicInfoView.element?.device}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    margin: EdgeInsets.only(right: 80.rpx),
                    child: InkWell(
                      child: SizedBox(
                          width: 130.rpx,
                          height: 130.rpx,
                          child: dynamicUserList.firstWhereOrNull((element) => element.id == userState.uid.value)== null ?
                          Image.asset("assets/icon/good.png",
                              fit: BoxFit.fill)
                              : Image.asset("assets/icon/good.png",
                              fit: BoxFit.fill,
                              color: Colors.blue)
                      ),
                      onTap: () {
                        thumbLike(element);
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
            Visibility(
              visible: dynamicUserList.isNotEmpty,
              child: Container(
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
                          showFriendsLikesWidget();
                        },
                      ),
                    ),
                    Expanded(
                        child: buildCommentLikeList(dynamicInfoView.commentLikeUserList ?? [])
                    ),
                  ],
                ),
              ),
            ),
            //评论信息
            Container(
              margin: EdgeInsets.only(top: 30.rpx,left: 10.rpx),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: buildCommentList(dynamicInfoView),
              ),
            ),
            //评论栏
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
                            image: userLogic.buildPortraitWidget().image,
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                  Expanded(
                      child: SizedBox(
                        height: 150.rpx,
                        child: TextField(
                          controller: controller,
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
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 50.rpx,right: 50.rpx),
                      padding: EdgeInsets.only(top: 30.rpx,bottom: 30.rpx,left: 50.rpx,right: 50.rpx),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5.rpx)
                      ),
                      child: Center(
                        child: Text(
                          "发送",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      insertComment(dynamicInfoView.element!, controller.text);
                      controller.text = "";
                    },
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
   * @date 2023/11/20 14:22
   * @description 插入评论数据
   */
  insertComment(SpaceDynamic element,String text) async{
    Log.i("插入评论数据");
    SpaceDynamicComment comment = SpaceDynamicComment(dynamicId: element.id,uid: userState.uid.value,comment: text);
    var result = await SpaceAPI.insertSpaceDynamicComment(comment);
    if(result >= 1){
      int index = state.dynamicViewInfoList.value.indexWhere((ele){
        var dynamicId = ele.viewInfo?.element?.id ?? -1;
        return dynamicId == element.id;
      });
      var commentList = state.dynamicViewInfoList[index].viewInfo?.commentViewList ?? [];
      var newCommentList = <SpaceCommentView>[];
      newCommentList.addAll(commentList);
      comment.id = result;
      SpaceCommentView commentView = SpaceCommentView(userState.user.value, comment);
      newCommentList.add(commentView);
      state.dynamicViewInfoList[index].viewInfo?.commentViewList = newCommentList;
      state.dynamicViewInfoList.refresh();
      BotToast.showText(text: "评论成功！");
    }else{
      BotToast.showText(text: "评论失败！");
    }
  }

  /*
   * @author Marinda
   * @date 2023/11/22 16:31
   * @description 构建朋友聊天控件
   */
  showFriendsLikesWidget() {
    var widget = Scaffold(
      backgroundColor: Colors.black.withOpacity(.3),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            InkWell(
              child: SizedBox.expand(),
              onTap: ()=> OverlayManager().removeOverlay("moreLike"),
            ),
            Align(
              alignment: Alignment.center,
              child: FractionallySizedBox(
                widthFactor: .8,
                heightFactor: .4,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 50.rpx,left: 50.rpx),
                        color: Colors.grey.withOpacity(.3),
                        height: 200.rpx,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(),
                            Container(
                              child: Text(
                                "点赞列表",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16
                                ),
                              ),
                            ),
                            Container(
                              child: InkWell(
                                child: SizedBox(
                                  width: 80.rpx,
                                  height: 80.rpx,
                                  child: Image.asset("shanchu2.png".icon,fit: BoxFit.fill),
                                ),
                                onTap: ()=>OverlayManager().removeOverlay("moreLike"),
                              ),
                            )
                          ],
                        ),
                      ),
                      //构建列表
                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: buildLikeUserWidget()
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
    OverlayManager().createOverlay("moreLike", widget);
  }

  /*
   * @author Marinda
   * @date 2023/11/22 16:49
   * @description 构建更多点赞用户的widget
   */
  buildLikeUserWidget(){
    return state.moreLikesList.value.map((e){
      return Container(
        margin: EdgeInsets.only(top: 50.rpx),
        padding: EdgeInsets.only(left: 50.rpx,right: 50.rpx),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: SizedBox(
                width: 100.rpx,
                height: 100.rpx,
                child: Image.asset("good.png".icon,fit: BoxFit.fill,color: Colors.blue,),
              ),
              margin: EdgeInsets.only(right: 50.rpx),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20.rpx),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100000),
                          image: DecorationImage(
                              image: userLogic.buildPortraitWidget(1,e.portrait!).image,
                              fit: BoxFit.fill
                          )
                      ),
                    ),
                    Container(
                      child: Text(
                        "${e.username}",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
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
   * @date 2023/11/22 10:47
   * @description 构建图像控件
   */
  buildImageWidget(SpaceDynamic spaceDynamic){
    List<Widget> widgetList = [];
    String content = spaceDynamic.image ?? "";
    //修复后台图像单引号路径问题，导致显示图像异常
    String filterContent = content.replaceAll("'",'"');
    if(content=="" || content == null){
      return <Widget>[];
    }else{
      var jsonList = json.decode(filterContent);
      if(jsonList is List){
        for(var i = 0 ;i<jsonList.length;i++){
          var imgElement = jsonList[i];
          var imgWidget = Container(
            width: 800.rpx,
            margin: EdgeInsets.only(right: 40.rpx,bottom: 50.rpx,),
            height: 600.rpx,
            child: CacheImageHandle.containsImageCache(imgElement) == false ? Image.network(imgElement,fit: BoxFit.cover) :userLogic.buildPortraitWidget(1,
              "${imgElement}",
            ),
          );
          widgetList.add(imgWidget);
        }
      }
    }

    return widgetList;
  }

  /*
   * @author Marinda
   * @date 2023/8/31 17:13
   * @description 构建内容控件
   */
  buildContentWidget(SpaceDynamic spaceDynamic){
    // int type = spaceDynamic.type ?? 0;
    String content = spaceDynamic.content ?? "";
    return Container(
      alignment: Alignment.topLeft,
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
      //这里是避免出现0个人觉得很赞这种情况！
      if(len - 3 >=1){
        int count = len-3>=1 ? len-1 : -1;
        //追加结尾
        textSpanList.add(TextSpan(
          text: "等${(len - 3)}个人觉得很赞",
          style: TextStyle(
              color: Colors.black,
              fontSize: 16
          ),
        ),);
        var likeList = <User>[];
        for(var i = count;i<len;i++){
          var element = commentLikeUserList[i];
          likeList.add(element);
        }
        state.moreLikesList.value = likeList;
      }
    }else{
      for(var i = 0;i<commentLikeUserList.length;i++){
        var user = commentLikeUserList[i];
        String userName = user.username ?? "";
        var textSpan = TextSpan(
            text: "${userName}${i == commentLikeUserList.length-1 ? "" : "、"}",
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

  /*
   * @author Marinda
   * @date 2023/9/1 11:33
   * @description 点赞
   */
  thumbLike(SpaceDynamicView dynamicView) async{
    SpaceDynamicInfoView dynamicInfoView = dynamicView.viewInfo!;
    List<User> dynamicUserList = dynamicInfoView.commentLikeUserList ?? [];
    var existsUser = dynamicUserList.firstWhereOrNull((element) => element.id == userState.uid.value);
    int dynamicId = dynamicInfoView.element?.id ?? -1;
    int uid = userState.uid.value;
    //索引
    int index = state.dynamicViewInfoList.indexWhere((element) => element.tag == dynamicView.tag);
    SpaceDynamicLike spaceDynamicLike = SpaceDynamicLike(dynamicId: dynamicId,uid: uid);
    SpaceDynamic targetDynamic = dynamicInfoView.element!;
    //更改点赞用户列表
    List<User> newUserList = [];
    if(existsUser == null){
      //找到目标动态对象
      Log.i("index: ${index},当前动态tag: ${dynamicView.tag},动态id: ${dynamicId}");

      newUserList.addAll(dynamicUserList);
      User user = userState.user.value;
      newUserList.add(user);
      //替换一个新的目标对象
      SpaceDynamicInfoView spaceDynamicInfoView = SpaceDynamicInfoView(targetDynamic, newUserList,dynamicInfoView.commentViewList);
      SpaceDynamicView newSpaceDynamicView = SpaceDynamicView(user: dynamicView.user,viewInfo: spaceDynamicInfoView,tag: dynamicView.tag);
      state.dynamicViewInfoList[index] = newSpaceDynamicView;
      Log.i("${uid}点赞${dynamicId}成功");
      //异步追加即可，本地在指定条目上做更改
      SpaceAPI.insertDynamicLike(spaceDynamicLike);
    }else{
      //存在点赞
      newUserList.addAll(dynamicUserList);
      int targetIndex = newUserList.indexWhere((element) => element.id == uid);
      Log.i("移除目标索引：${targetIndex}");
      newUserList.removeAt(targetIndex);
      //替换一个新的目标对象
      SpaceDynamicInfoView spaceDynamicInfoView = SpaceDynamicInfoView(targetDynamic, newUserList,dynamicInfoView.commentViewList);
      SpaceDynamicView newSpaceDynamicView = SpaceDynamicView(user: dynamicView.user,viewInfo: spaceDynamicInfoView,tag: dynamicView.tag);
      state.dynamicViewInfoList[index] = newSpaceDynamicView;
      SpaceAPI.deleteDynamicLike(spaceDynamicLike);
    }
    state.dynamicViewInfoList.refresh();
  }

  buildCommentList(SpaceDynamicInfoView view){
    List<Widget> widgetList = [];
    var list = view.commentViewList ?? [];
    for(var i = 0;i<list.length;i++){
      var e = list[i];
      var spaceDynamic = view.element!;
      User user = e.user!;
      var widget = Container(
        margin: EdgeInsets.only(bottom: 10.rpx),
        child: Row(
          children: [
            InkWell(
              child: Container(
                child: Text("${user.username}：",style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14
                ),),
              ),
              onTap: ()=>print("进入${user.username}空间"),
            ),
            Expanded(
                child: InkWell(
                  child: Container(
                    child: Text(
                      "${e.comment?.comment}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                  onLongPress: (){
                    // BotToast.cleanAll();
                    BotToast.showAnimationWidget(toastBuilder: (val){
                      return Scaffold(
                        backgroundColor: Colors.black.withOpacity(.3),
                        body: Container(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              InkWell(
                                child: SizedBox.expand(),
                                onTap: ()=>BotToast.cleanAll(),
                              ),
                              Align(
                                child: FractionallySizedBox(
                                  widthFactor: .8,
                                  child: Container(
                                    color: Colors.white,
                                    height: 1200.rpx,
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        //头部
                                        Container(
                                          color: Colors.blue,
                                          height: 130.rpx,
                                          padding: EdgeInsets.only(top: 10.rpx,left: 50.rpx,right: 50.rpx,bottom: 10.rpx),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(),
                                              Container(
                                                child: Text(
                                                  "温馨提示",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: ()=>BotToast.cleanAll(),
                                                child: Container(
                                                  child: SizedBox(
                                                      width: 70.rpx,
                                                      height: 70.rpx,
                                                      child: Image.asset(
                                                        "shanchu2.png".icon,
                                                        fit: BoxFit.cover,
                                                        color: Colors.white,
                                                      )
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        //  内容
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 50.rpx,right: 50.rpx,bottom: 30.rpx),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: Text("是否删除该条评论",
                                                        style: TextStyle(color: Colors.black,fontSize: 16)
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(bottom: 20.rpx),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      InkWell(
                                                        child: Container(
                                                          width: 300.rpx,
                                                          color: Colors.blue,
                                                          child: Center(
                                                            child: Text(
                                                              "提交",
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 14
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: ()=>removeComment(spaceDynamic,e.comment!),
                                                      ),
                                                      Container(width: 100.rpx),
                                                      InkWell(
                                                        child: Container(
                                                          width: 300.rpx,
                                                          color: Colors.grey,
                                                          child: Center(
                                                            child: Text(
                                                              "取消",
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 14
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: ()=>BotToast.cleanAll(),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }, animationDuration: Duration(seconds: 1));
                  },
                )
            )
          ],
        ),
      );
      widgetList.add(widget);
    }
    return widgetList;
  }

  removeComment(SpaceDynamic element,SpaceDynamicComment comment) async{
    int id = element.id!;
    Log.i("删除id动态为: ${id}的评论");

    int index = state.dynamicViewInfoList.value.indexWhere((ele){
      var dynamicId = ele.viewInfo?.element?.id ?? -1;
      return dynamicId == element.id;
    });
    var commentList = state.dynamicViewInfoList[index].viewInfo?.commentViewList ?? [];
    var newCommentList = <SpaceCommentView>[];
    newCommentList.addAll(commentList);
    int cid = commentList.indexWhere((element)=> element.comment?.id! == comment.id!);
    newCommentList.removeAt(cid);
    state.dynamicViewInfoList[index].viewInfo?.commentViewList = newCommentList;
    state.dynamicViewInfoList.refresh();
    int result = await SpaceAPI.deleteDynamicCommentById(comment.id!);
    if(result >= 1){
      BotToast.showText(text: "删除成功！");
    }else{
      BotToast.showText(text: "删除失败！");
    }
    Future.delayed(Duration(seconds: 1),(){
      BotToast.cleanAll();
    });

  }


}
