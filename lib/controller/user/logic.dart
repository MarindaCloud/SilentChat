import 'package:get/get.dart';
import 'package:silentchat/util/date_time_util.dart';

import 'state.dart';

class UserLogic extends GetxController {
  final UserState state = UserState();

  /*
   * @author Marinda
   * @date 2023/6/25 10:29
   * @description 1男2女
   */
  String getSex(){
    int sex = state.user.value.sex ?? -1;
    return sex == 1 ? "男" : "女";
  }

  /*
   * @author Marinda
   * @date 2023/6/25 10:30
   * @description 获取出生日期
   */
  String getDate(){
    DateTime? dateTime = state.user.value.birthday;
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
    int birthDayYear = state.user.value.birthday?.year ?? 0;
    return (DateTime.now().year - birthDayYear);
  }

  /*
   * @author Marinda
   * @date 2023/6/25 10:44
   * @description 获取位置
   */
  String getLocation(){
    return state.user.value.location.toString();
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
}
