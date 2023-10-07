import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/common/expansion/image_path.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:flukit/flukit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'logic.dart';

class EditGroupInfoPage extends StatelessWidget {
  EditGroupInfoPage({Key? key}) : super(key: key);

  final logic = Get.find<EditGroupInfoLogic>();
  final state = Get
      .find<EditGroupInfoLogic>()
      .state;
  final userLogic = Get.find<UserLogic>();
  final userState = Get
      .find<UserLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Container(
          color: Color.fromRGBO(247, 247, 247, 1),
          child: SafeArea(
            child: Container(
              child: Column(
                children: [
                  // 头部
                  Container(
                    width: Get.width,
                    margin: EdgeInsets.only(bottom: 50.rpx),
                    padding: EdgeInsets.only(top: 50.rpx, bottom: 50.rpx),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.translate(
                            offset: Offset(130.rpx, 0),
                            child: IconButtonComponent.build(
                              "back", color: Colors.black,
                              onClick: logic.close,)
                        ),
                        Container(
                          child: Text(
                              "群组管理", style: TextStyle(fontSize: 16)),
                        ),
                        SizedBox()
                      ],
                    ),
                  ),
                  //  群banner 和群号相关信息
                  Container(
                    height: 650.rpx,
                    // height: 600.rpx,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            top: 0.rpx,
                            left: 50.rpx,
                            //头像
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 50.rpx, bottom: 50.rpx),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 150.rpx),
                                    width: 500.rpx,
                                    height: 500.rpx,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: userLogic
                                              .buildPortraitWidget(1,
                                              state.group.value.portrait ?? "")
                                              .image,
                                          fit: BoxFit.fill
                                      ),
                                    ),
                                  ),
                                  //  群信息
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        //群名
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 100.rpx),
                                          child: Text(
                                            "${state.group.value.name}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20
                                            ),
                                          ),
                                        ),
                                        //群号
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 100.rpx),
                                          child: Text(
                                            "群号：${state.group.value.number}",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    153, 153, 153, 1),
                                                fontSize: 14
                                            ),
                                          ),
                                        ),
                                        //群号
                                        Container(
                                          child: Text.rich(
                                            TextSpan(
                                                children: [
                                                  TextSpan(text: "群排行：",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14)),
                                                  TextSpan(
                                                      text: "${state.group.value
                                                          .rank}",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 14)),
                                                ]
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 100.rpx, bottom: 100.rpx),
                    padding: EdgeInsets.only(left: 50.rpx, right: 50.rpx),
                    child: Column(
                      children: [
                        ...logic.buildGroupInfoList(),
                        //群成员
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.only(top: 100.rpx),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 50.rpx),
                                  child: Row(
                                    children: [
                                      //详情
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: 50.rpx),
                                        child: SizedBox(
                                          width: 80.rpx,
                                          height: 80.rpx,
                                          child: Image.asset(
                                            "groupstaff.png".icon,
                                            fit: BoxFit.fill,
                                            color: Colors.black,),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "群成员（15）",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                //群员头像
                                Container(
                                  child: Row(
                                    children: logic.buildGroupStaff(),
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            print("群成员");
                          },
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: BarChart(
                        BarChartData(
                          maxY: 10,
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
                                      text = "管理员";
                                      break;
                                  }
                                  return SideTitleWidget(
                                      child: Text(
                                          text,
                                        style: TextStyle(
                                          color: Colors.red,
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
                                      toY: 5,
                                    color: Colors.blue
                                  ),
                                  BarChartRodData(
                                      fromY: 0,
                                      toY: 10,
                                      color: Colors.blue
                                  )
                                ]),
                            // BarChartGroupData(x: 70)
                          ]
                        ),
                        swapAnimationCurve: Curves.linear,
                        swapAnimationDuration: Duration(milliseconds: 150),
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
