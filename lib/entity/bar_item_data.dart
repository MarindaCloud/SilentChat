import 'package:silentchat/entity/chart_item.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
/**
 * @author Marinda
 * @date 2023/9/19 15:18
 * @description 条形项目data
 */
class BarItemData extends ChartItem{
  double? fromY;
  double? toY;
  Color? color = Colors.blue;
  double? width = 8;
  BorderSide? borderSide;
  BorderRadius? borderRadius = BorderRadius.zero;

  BarItemData(this.fromY,this.toY,{this.color,this.width,this.borderSide,this.borderRadius});

  /*
   * @author Marinda
   * @date 2023/9/19 15:28
   * @description 转成相关图表Item
   */
  @override
  dynamic toChartItem() {
    return BarChartRodData(fromY: fromY,toY: toY!,color: color,width: width,borderSide: borderSide,borderRadius: borderRadius);
  }

}