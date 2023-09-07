import 'package:silentchat/enum/global_page.dart';
import 'package:get/get.dart';
import 'package:silentchat/view/append/binding.dart';
import 'package:silentchat/view/append/view.dart';
import 'package:silentchat/view/append_group/binding.dart';
import 'package:silentchat/view/append_group/view.dart';
import 'package:silentchat/view/append_message/binding.dart';
import 'package:silentchat/view/append_message/view.dart';
import 'package:silentchat/view/chat/binding.dart';
import 'package:silentchat/view/chat/view.dart';
import 'package:silentchat/view/contact/binding.dart';
import 'package:silentchat/view/contact/view.dart';
import 'package:silentchat/view/dynamic/binding.dart';
import 'package:silentchat/view/dynamic/view.dart';
import 'package:silentchat/view/edit_image/binding.dart';
import 'package:silentchat/view/edit_image/view.dart';
import 'package:silentchat/view/index/binding.dart';
import 'package:silentchat/view/index/view.dart';
import 'package:silentchat/view/login/binding.dart';
import 'package:silentchat/view/login/view.dart';
import 'package:silentchat/view/message/view.dart';
import 'package:silentchat/view/qr/binding.dart';
import 'package:silentchat/view/qr/view.dart';
import 'package:silentchat/view/register/binding.dart';
import 'package:silentchat/view/register/view.dart';
import 'package:silentchat/view/space/binding.dart';
import 'package:silentchat/view/space/view.dart';
import 'package:silentchat/view/user_info/binding.dart';
import 'package:silentchat/view/user_info/view.dart';
import 'package:silentchat/view/verify/binding.dart';
import 'package:silentchat/view/verify/view.dart';

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
  static String qr = GlobalPage.qr.router;
  static String userInfo = GlobalPage.userInfo.router;
  static String appendMessage = GlobalPage.appendMessage.router;
  static String verify = GlobalPage.verify.router;
  static String appendGroup = GlobalPage.appendGroup.router;
  static String space = GlobalPage.space.router;
  static String register= GlobalPage.register.router;
  static String editImage = GlobalPage.editImage.router;

  static List<GetPage> pages = [
    GetPage(name: message, page: ()=>MessagePage(),binding: MessageBinding()),
    GetPage(name: login, page: ()=>LoginPage(),binding: LoginBinding()),
    GetPage(name: index, page: ()=>IndexPage(),binding: IndexBinding()),
    GetPage(name: contact, page: ()=>ContactPage(),binding: ContactBinding()),
    GetPage(name: dynamic, page: ()=>DynamicPage(),binding:DynamicBinding()),
    GetPage(name: chat, page: ()=>ChatPage(),binding:ChatBinding()),
    GetPage(name: append, page: ()=>AppendPage(),binding:AppendBinding()),
    GetPage(name: qr, page: ()=>QrPage(),binding:QrBinding()),
    GetPage(name: userInfo, page: ()=>UserInfoPage(),binding: UserInfoBinding()),
    GetPage(name: appendMessage, page: ()=>AppendMessagePage(),binding: AppendMessageBinding()),
    GetPage(name: verify, page: ()=>VerifyPage(),binding: VerifyBinding()),
    GetPage(name: appendGroup, page: ()=> AppendGroupPage(),binding: AppendGroupBinding()),
    GetPage(name: space, page: ()=> SpacePage(),binding: SpaceBinding()),
    GetPage(name: register, page: ()=> RegisterPage(),binding: RegisterBinding()),
    GetPage(name: editImage, page: ()=> EditImagePage(),binding: EditImageBinding()),
  ];

  AppPage();

}