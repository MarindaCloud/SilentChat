import 'package:get/get.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/entity/space_dynamic.dart';
import 'package:silentchat/entity/space_dynamic_info_view.dart';
import 'package:silentchat/entity/space_dynamic_view.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/util/date_time_util.dart';

import 'state.dart';

class SpaceLogic extends GetxController {
  final SpaceState state = SpaceState();
  final userLogic = Get.find<UserLogic>();
  final userState = Get.find<UserLogic>().state;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/8/18 16:29
   * @description 初始化空间动态详情
   */
  void initSpaceInfo() async{
    User user = await userLogic.selectByUid(3);
    SpaceDynamic spaceDynamic = SpaceDynamic(id: 1,uid: 3,content: "人不行别怪路不平",device: "IPhone6 Plus",time: DateTimeUtil.formatDateTime(DateTime.now(),format: DateTimeUtil.ymdhn),type: 1);
    List<User> likeUserList = [];
    for(var i = 4;i<=6;i++){
     likeUserList.add(await userLogic.selectByUid(i));
    }
    SpaceDynamicInfoView infoView = SpaceDynamicInfoView(spaceDynamic,likeUserList);
    SpaceDynamicView dynamicView = SpaceDynamicView(user: user,viewInfo: infoView);
    state.dynamicViewInfoList.add(dynamicView);
  }
}
