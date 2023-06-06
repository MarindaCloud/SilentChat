
import 'package:date_format/date_format.dart';
/**
 * @author Marinda
 * @date 2023/6/5 14:19
 * @description 日期时间工具
 */
class DateTimeUtil{
  static String ymd = "yyyy - mm - dd";
  static String ymdhns = "yyyy - mm - dd HH : nn : ss";
  static String ymdhn = "yyyy - mm - dd HH : nn";
  static String hn = "HH : nn";
  /*
   * @author Marinda
   * @date 2023/6/5 14:33
   * @description 格式化日期条件
   */
  static String formatDateTime(DateTime dateTime,{String format = ""}){
    //由于传递list，字符串分割成数组则需要分割条件，于是给提供的静态变量都是携带空格
    List<String> formatArgsList = format.split(" ").toList();
    String formatDateTime = formatDate(dateTime,formatArgsList);
    return formatDateTime;
  }

  /*
   * @author Marinda
   * @date 2023/6/5 14:33
   * @description 获取星期 时期和时分的时间
   */
  static String formatWeekDateTime(DateTime dateTime){
    int weekDay = dateTime.weekday;
    String weekString = getWeek(weekDay);
    String peroidString = getHourPeroid(dateTime);
    String dateString = formatDateTime(dateTime,format: hn);
    return "${weekString} ${peroidString} ${dateString}";
  }

  /*
   * @author Marinda
   * @date 2023/6/5 14:36
   * @description 根据weekDay获取中文的星期几
   */
  static String getWeek(int weekDay){
    String weekString = "星期";
    List<String> list = ["","一","二","三","四","五","六","天"];
    return "${weekString}${list[weekDay]}";
  }

  /*
   * @author Marinda
   * @date 2023/6/5 15:16
   * @description 这方法是用来获取一个时间中符合指定时间间隔的所有时间列表
   * 提供的参数有一个时间，以及所有时间列表，还有间隔条件
   */
  static List<DateTime> getDateTimeInterval(DateTime startTime,List<DateTime> dateTimeList,Duration interval){
    List<DateTime> timeList = [];
    DateTime intervalTime = startTime.add(interval);
    for(DateTime dateTime in dateTimeList){
      Duration duration = intervalTime.difference(dateTime);
      //指定区间范围
      if(duration.inMinutes <=interval.inMinutes) {
        timeList.add(dateTime);
      }
    }
    return timeList;
  }

  /*
   * @author Marinda
   * @date 2023/6/5 14:41
   * @description 获取小时的时间段
   */
  static String getHourPeroid(DateTime dateTime){
    String peroidString = "";
    int hour = dateTime.hour;
    if(hour >=6 && hour<=12){
      peroidString = "上午";
    }else if(hour >= 13 && hour<=18){
      peroidString = "下午";
    }else if(hour >= 19 && hour <=24){
      peroidString = "晚上";
    }
    return peroidString;
  }
}