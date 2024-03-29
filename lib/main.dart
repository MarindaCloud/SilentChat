import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:silentchat/controller/system/logic.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/enum/global_page.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/socket/socket_handle.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/log.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:silentchat/util/overlay_manager.dart';
import 'package:get_storage/get_storage.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //强制竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  // 全部去除
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await Log.initLogger();
  await GetStorage.init();
  initService();

  try {
  }catch(e){
    Log.e("初始化失败！");
  }finally{
    await GetStorage.init();
    runApp(MainApp());
  }

}

class MainApp extends StatefulWidget{
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  State<StatefulWidget> createState() {
    return MainState();
  }

}

class MainState extends State<MainApp> with WidgetsBindingObserver{

  MainState();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FontRpx.initialize();
    final TransitionBuilder botToastBuilder = BotToastInit();
    return GetMaterialApp(
      navigatorKey: MainApp.navigatorKey,
      //移除一下Debug图标
      debugShowCheckedModeBanner: false,
      title: "默讯",
      color: Colors.white,
      smartManagement: SmartManagement.full,
      // 全局设置默认字体
      theme: ThemeData(
          fontFamily: 'HarmonyOS_Sans',
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStateProperty
                  .all(EdgeInsets.zero),
              backgroundColor: MaterialStateProperty.all(
                  const Color(0xff0061d1)),
            ),
          )
      ),
      // 合并多个builder
      builder: (context, child)=> botToastBuilder(context, child),
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: AppPage.login,
      getPages: AppPage.pages,
      // defaultTransition: Transition.zoom
    );
  }
}


/*
 * @Author ZISE
 * @Description //初始化service
 * @Date 11:12 2022/7/1
 **/
initService() {
  Get.put(SocketHandle());
  Get.put(SystemLogic());
  Get.put(OverlayManager());
  Get.put(UserLogic());
}
