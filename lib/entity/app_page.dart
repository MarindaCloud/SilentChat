import 'package:silentchat/enum/global_page.dart';
import 'package:get/get.dart';
import 'package:silentchat/view/login/binding.dart';
import 'package:silentchat/view/login/view.dart';
import 'package:silentchat/view/message/view.dart';

import '../view/message/binding.dart';
/**
 * @author Marinda
 * @date 2023/5/25 10:49
 * @description 应用的Page页面实体类
 */
class AppPage{
  static String message = GlobalPage.message.router;
  static String contact = GlobalPage.contact.router;
  static String login = GlobalPage.login.router;

  static List<GetPage> pages = [
    GetPage(name: message, page: ()=>MessagePage(),binding: MessageBinding()),
    GetPage(name: login, page: ()=>LoginPage(),binding: LoginBinding()),
  ];

  AppPage();

}