import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:flukit/flukit.dart';
import 'state.dart';

/**
 * @author Marinda
 * @date 2023/9/18 10:45
 * @description 编辑群组信息
 */
class EditGroupInfoLogic extends GetxController {
  final EditGroupInfoState state = EditGroupInfoState();


  @override
  void onInit() {
    state.group.value = Get.arguments;

    super.onInit();
  }

  close(){
    Get.back();
  }

  /*
   * @author Marinda
   * @date 2023/9/18 15:57
   * @description 构建群员头像
   */
  buildGroupStaff(){
    int count = 10;
    double maxWidth = 0;
    List<Widget> widgetList = [];
    double viewWidget = Get.width;
    for(int i = 0;i<count;i++){
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
            image: Image.asset("assets/user/portait.png",fit: BoxFit.fill).image,
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.rpx),
                      child: Text(
                        state.group.value.description ?? "",
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1)
                        ),
                        overflow: TextOverflow.ellipsis,
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
        onTap: (){
          print("${key}");
        },
      );
      widgetList.add(widget);
    });
    return widgetList;
  }
}
