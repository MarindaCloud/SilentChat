import 'package:silentchat/enum/global_page.dart';
import 'package:get/get.dart';
import 'package:silentchat/view/append/binding.dart';
import 'package:silentchat/view/append/view.dart';
import 'package:silentchat/view/chat/binding.dart';
import 'package:silentchat/view/chat/view.dart';
import 'package:silentchat/view/contact/binding.dart';
import 'package:silentchat/view/contact/view.dart';
import 'package:silentchat/view/dynamic/binding.dart';
import 'package:silentchat/view/dynamic/view.dart';
import 'package:silentchat/view/index/binding.dart';
import 'package:silentchat/view/index/view.dart';
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
  static String index = GlobalPage.main.router;
  static String dynamic = GlobalPage.dynamic.router;
  static String chat = GlobalPage.chat.router;
  static String append = GlobalPage.append.router;

  static List<GetPage> pages = [
    GetPage(name: message, page: ()=>MessagePage(),binding: MessageBinding()),
    GetPage(name: login, page: ()=>LoginPage(),binding: LoginBinding()),
    GetPage(name: index, page: ()=>IndexPage(),binding: IndexBinding()),
    GetPage(name: contact, page: ()=>ContactPage(),binding: ContactBinding()),
    GetPage(name: dynamic, page: ()=>DynamicPage(),binding:DynamicBinding()),
    GetPage(name: chat, page: ()=>ChatPage(),binding:ChatBinding()),
    GetPage(name: append, page: ()=>AppendPage(),binding:AppendBinding()),
  ];

  AppPage();

}