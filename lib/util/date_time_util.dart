
import 'package:date_format/date_format.dart';
import 'package:silentchat/util/log.dart';
/**
 * @author Marinda
 * @date 2023/6/5 14:19
 * @description 日期时间工具
 */
class DateTimeUtil{
  static List<String> ymd = ["yyyy","-","mm","-","dd"];
  static List<String> ymdhns = ["yyyy","-","mm","-","dd"," ","HH",":","nn",":","ss"];
  static List<String> ymdhn = ["yyyy","-","mm","-","dd"," ","HH",":","nn"];
  static List<String> hn = ["HH", ":", "nn"];
  static List<String> md = ["mm", "月", "dd","日"];
  /*
   * @author Marinda
   * @date 2023/6/5 14:33
   * @description 格式化日期条件
   */
  static String formatDateTime(DateTime dateTime,{List<String>? format}){
    //由于传递list，字符串分割成数组则需要分割条件，于是给提供的静态变量都是携带空格
    List<String> formatArgsList = format ?? [];
    String formatDateTime = formatDate(dateTime,formatArgsList);
    return formatDateTime;
  }

  /*
   * @author Marinda
   * @date 2023/6/5 14:33
   * @description 格式化日期条件
   */
  static String formatCustomDateTime(DateTime dateTime,List<String> formatList){
    //由于传递list，字符串分割成数组则需要分割条件，于是给提供的静态变量都是携带空格
    String formatDateTime = formatDate(dateTime,formatList);
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
   * @date 2023/6/12 14:46
   * @description 格式化当前时间 用来做message页展示
   */
  static String formatToDayDateTime(DateTime dateTime){
    String peroidString = getHourPeroid(dateTime);
    String dateString = formatDateTime(dateTime,format: hn);
    return "${peroidString} ${dateString}";
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
  static String getConstellAtion(DateTime birthDay){
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
  static bool validDateTimeInRange(DateTime date,DateTime start,DateTime end){
    //如果该日期和起始日期相同则直接返回true
    if(date.year == start.year && date.month == start.month && date.day == start.day){
      return true;
    }
    return start.isBefore(date) && end.isAfter(date);
  }
}