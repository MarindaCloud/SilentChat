import 'package:silentchat/entity/space_dynamic_info_view.dart';
import 'package:silentchat/entity/user.dart';

/**
 * @author Marinda
 * @date 2023/8/18 16:11
 * @description 动态
 */
class SpaceDynamicView{
  User? user;
  SpaceDynamicInfoView? viewInfo;
  String? tag;

  SpaceDynamicView({this.user, this.viewInfo,this.tag});
}