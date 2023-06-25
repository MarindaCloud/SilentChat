import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/util/date_time_util.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'package:silentchat/view/user_info/logic.dart';
import 'package:silentchat/view/user_info/state.dart';

/**
 * @author Marinda
 * @date 2023/6/21 14:48
 * @description 主要内容组件
 */
class MainComponent extends StatefulWidget {

  final UserInfoLogic userInfoLogic;
  final UserInfoState userInfoState;

  MainComponent(this.userInfoLogic, this.userInfoState);

  @override
  State<StatefulWidget> createState() {
    return MainComponentState();
  }
}

class MainComponentState extends State<MainComponent> {

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              //头像 & 基础信息
              Container(
                margin: EdgeInsets.only(bottom: 50.rpx),
                height: 300.rpx,
                child: Row(
                  children: [
                    Container(
                      width: 300.rpx,
                      height: 300.rpx,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10000),
                          image: DecorationImage(
                              image: Image
                                  .asset("assets/user/portait.png")
                                  .image,
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    SizedBox(
                      width: 70.rpx,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "${widget.userInfoState.user.value.username}",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 50.rpx),
                          Container(
                            child: Text.rich(
                                TextSpan(
                                    children: [
                                      TextSpan(text: "SCID: ",
                                          style: TextStyle(color: Colors.grey,
                                              fontSize: 16)),
                                      TextSpan(
                                          text: "${widget.userInfoState.user
                                              .value.number}",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16))
                                    ]
                                )
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //性别和其他信息
              Container(
                child: Row(
                  children: [
                    //性别信息
                    Container(
                      padding: EdgeInsets.only(right: 50.rpx),
                      decoration: BoxDecoration(
                          border: Border(right: BorderSide(
                              color: Color.fromRGBO(207, 207, 207, 1),
                              width: 1))
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 80.rpx,
                              height: 80.rpx,
                              child: Image.asset(
                                  getSex() == "男" ? "assets/icon/man.png" : "assets/icon/woman.png", color: getSex() == "男" ? Colors.blue : Colors.pink,
                                  fit: BoxFit.fill)
                          ),
                          SizedBox(width: 10.rpx),
                          Text(getSex(),
                              style: TextStyle(color: Colors.grey, fontSize: 16)
                          )
                        ],
                      ),
                    ),
                    //年龄
                    Container(
                      margin: EdgeInsets.only(left: 50.rpx),
                      padding: EdgeInsets.only(right: 50.rpx),

                      decoration: BoxDecoration(
                          border: Border(right: BorderSide(
                              color: Color.fromRGBO(207, 207, 207, 1),
                              width: 1))),
                      child: Text(
                        "${getAge()}岁",
                        style: TextStyle(color: Colors.grey, fontSize: 16),),
                    ),
                    //月份，星座
                    Container(
                        margin: EdgeInsets.only(left: 50.rpx),
                        padding: EdgeInsets.only(right: 50.rpx),
                        decoration: BoxDecoration(
                            border: Border(right: BorderSide(
                                color: Color.fromRGBO(207, 207, 207, 1),
                                width: 1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Text(getDate(), style: TextStyle(
                                  color: Colors.grey, fontSize: 16)),
                            ),
                            SizedBox(width: 50.rpx),
                            Container(
                              child: Text(getConstellAtion(),
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16),),
                            )
                          ],
                        )
                    ),
                    //国家 具体到省市
                    Container(
                        margin: EdgeInsets.only(left: 50.rpx),
                        padding: EdgeInsets.only(right: 50.rpx),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(getProvince(), style: TextStyle(
                                  color: Colors.grey, fontSize: 16)),
                            ),
                            SizedBox(width: 50.rpx),
                            Container(
                              child: Text(getCity(),
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16),),
                            )
                          ],
                        )
                    )
                  ],
                ),
              ),
              SizedBox(height: 50.rpx),
              //  个签
              Container(
                alignment: Alignment.topLeft,
                child: Text.rich(
                    TextSpan(
                        children: [
                          TextSpan(text: "个性签名：",
                              style: TextStyle(fontSize: 16, color: Colors
                                  .grey)),
                          TextSpan(text: widget.userInfoState.user.value.signature ?? "这个人很懒，没有留下任何痕迹！",
                              style: TextStyle(color: Colors.black,
                                  fontSize: 16))
                        ]
                    )
                ),
              ),
              SizedBox(height: 30.rpx),
              //个人世界
              TextButton(
                child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70.rpx,
                                height: 70.rpx,
                                child: Image.asset(
                                  "assets/icon/dynamic.png", fit: BoxFit.fill,
                                  color: Colors.orange,),
                              ),
                              SizedBox(width: 30.rpx),
                              Expanded(child: Text(
                                "${widget.userInfoState.user.value
                                    .username}的世界", style: TextStyle(
                                  color: Colors.grey, fontSize: 16),)),
                            ],
                          ),
                        ),
                        IconButtonComponent("qianwang", Colors.grey)
                      ],
                    )
                ),
                onPressed: () {
                  Log.i(
                      "进入${widget.userInfoState.user.value.username}的世界");
                },
              )
            ],
          ),
        ),
      );
    });
  }

  /*
   * @author Marinda
   * @date 2023/6/25 10:29
   * @description 1男2女
   */
  String getSex(){
    User user = widget.userInfoState.user.value;
    int sex = user.sex ?? -1;
    return sex == 1 ? "男" : "女";
  }

  /*
   * @author Marinda
   * @date 2023/6/25 10:30
   * @description 获取出生日期
   */
  String getDate(){
    User user = widget.userInfoState.user.value;
    DateTime? dateTime = user.birthday;
    if(dateTime == null){
      return "";
    }
    print('当前日期：${dateTime}');
    return DateTimeUtil.formatDateTime(dateTime,format: DateTimeUtil.md);
  }

  /*
   * @author Marinda
   * @date 2023/6/25 10:35
   * @description 获取年龄
   */
  int getAge(){
    User user = widget.userInfoState.user.value;
    int birthDayYear = user.birthday?.year ?? 0;
    return (DateTime.now().year - birthDayYear);
  }

  /*
   * @author Marinda
   * @date 2023/6/25 10:44
   * @description 获取位置
   */
  String getLocation(){
    User user = widget.userInfoState.user.value;
    return user.location.toString();
  }


  String getProvince(){
    String location = getLocation();
    String subString = location.substring(0,2);
    return subString ;
  }

  String getCity(){
    String location = getLocation();
    String subString = location.substring(2);
    return subString;
  }

  /*
   * @author Marinda
   * @date 2023/6/25 11:01
   * @description 获取星座
   * 12/22 - 1/19 摩羯
   * 1/20 - 2/18 水瓶
   * 2/19 - 3/20 双鱼座
   * 3/21 - 4/20 白羊座
   * 4/21 - 5/20 金牛座
   * 5/21 - 6/21 双子座
   * 6/22 - 7/22 巨蟹座
   * 7/23 - 8/22 狮子座
   * 8/23 - 9/22 处女座
   * 9/23 - 10/23 天秤座
   * 10/24 - 11/22 天蝎座
   * 11/23 - 12/21 射手座
   */
  String getConstellAtion(){
    User user = widget.userInfoState.user.value;
    DateTime birthDay = user.birthday ?? DateTime.now();
    if(birthDay == DateTime.now()){
      return "";
    }
    int year = birthDay?.year ?? 0;
    String constellAtion = "";
    //摩羯座
    if(validDateTimeInRange(birthDay, DateTime(year,12,22), DateTime(year,1,19))){
      constellAtion = "摩羯";
    }else if(validDateTimeInRange(birthDay, DateTime(year,1,20), DateTime(year,2,18))){
      constellAtion = "水瓶";
    }else if(validDateTimeInRange(birthDay, DateTime(year,2,19), DateTime(year,3,20))){
      constellAtion = "双鱼";
    }else if(validDateTimeInRange(birthDay, DateTime(year,3,21), DateTime(year,4,20))){
      constellAtion = "白羊";
    }else if(validDateTimeInRange(birthDay, DateTime(year,4,21), DateTime(year,5,20))){
      constellAtion = "金牛";
    }else if(validDateTimeInRange(birthDay,DateTime(year,5,21), DateTime(year,6,21))){
      constellAtion = "双子";
    }else if(validDateTimeInRange(birthDay, DateTime(year,6,22), DateTime(year,7,22))){
      constellAtion = "巨蟹";
    }else if(validDateTimeInRange(birthDay, DateTime(year,7,23), DateTime(year,8,22))){
      constellAtion = "狮子";
    }else if(validDateTimeInRange(birthDay, DateTime(year,8,23), DateTime(year,9,22))){
      constellAtion = "处女";
    }else if(validDateTimeInRange(birthDay, DateTime(year,9,23), DateTime(year,10,23))){
      constellAtion = "天秤";
    }else if(validDateTimeInRange(birthDay, DateTime(year,10,24), DateTime(year,11,22))){
      constellAtion = "天蝎";
    }else if(validDateTimeInRange(birthDay, DateTime(year,11,23), DateTime(year,12,21))){
      constellAtion = "射手";
    }
    Log.i("星座：${constellAtion}");
    return constellAtion+"座";
  }

  /*
   * @author Marinda
   * @date 2023/6/25 11:17
   * @description 校验日期范围
   */
  bool validDateTimeInRange(DateTime date,DateTime start,DateTime end){
    //如果该日期和起始日期相同则直接返回true
    if(date.year == start.year && date.month == start.month && date.day == start.day){
      return true;
    }
    return start.isBefore(date) && end.isAfter(date);
  }
}