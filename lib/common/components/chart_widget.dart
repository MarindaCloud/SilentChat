import 'package:flutter/material.dart';
import 'package:silentchat/entity/chart_item.dart';
import 'package:fl_chart/fl_chart.dart';
/**
 * @author Marinda
 * @date 2023/9/19 15:10
 * @description 图标组件
 */
class ChartComponent extends StatelessWidget{
  int? type;
  final List<ChartItem> elementList;
  double? max = 10;
  double? min = 0;
  final Function? titleFunction;
  //title在那个位置显示
  int? directionType = 3;
  double? titleSpace = 5;
  Color? bgColor = Colors.transparent;
  ChartComponent(this.type,this.titleFunction,this.elementList,{this.max,this.min,this.directionType,this.titleSpace,this.bgColor});

  @override
  Widget build(BuildContext context) {
    return buildWidget();
  }

  /*
   * @author Marinda
   * @date 2023/9/19 15:59
   * @description 构建view
   */
  buildWidget(){
    Widget? widget;
    switch(type){
      case 2:
        widget = BarChart(
          BarChartData(
            gridData: FlGridData(
              show: false
            ),
            maxY: max!,
            minY: min!,
            barGroups: [
              ...elementList.map((e) => e.toChartItem()).toList()
            ],
            titlesData: FlTitlesData(
              show: true,
              topTitles: directionType! == 1 ? AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value,meta){
                    return titleFunction!(value,meta);
                  },
                  reservedSize: this.titleSpace
                )
              ) : AxisTitles(),
              rightTitles: directionType! == 2 ? AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value,meta){
                        return titleFunction!(value,meta);
                      },
                      reservedSize: this.titleSpace
                  )
              ) : AxisTitles(),
              bottomTitles: directionType! == 3 ? AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value,meta){
                        return titleFunction!(value,meta);
                      },
                      reservedSize: this.titleSpace
                  )
              ) : AxisTitles(),
              leftTitles: directionType! == 4 ? AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value,meta){
                        return titleFunction!(value,meta);
                      },
                      reservedSize: this.titleSpace
                  )
              ) : AxisTitles(),
            ),
          ),
          swapAnimationCurve: Curves.linear,
          swapAnimationDuration: Duration(milliseconds: 150),
        );
        break;
    }
    return widget;
  }
}