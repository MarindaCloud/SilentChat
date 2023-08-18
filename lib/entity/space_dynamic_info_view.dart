import 'package:silentchat/entity/space_dynamic.dart';
import 'package:silentchat/entity/user.dart';

/**
 * @author Marinda
 * @date 2023/8/18 16:12
 * @description 空间动态详情视图
 */
class SpaceDynamicInfoView{
  SpaceDynamic? _element;
  List<User>? _commentLikeUserList;

  SpaceDynamicInfoView(this._element,this._commentLikeUserList);

  List<User>? get commentLikeUserList => _commentLikeUserList;

  set commentLikeUserList(List<User>? value) {
    _commentLikeUserList = value;
  }

  SpaceDynamic?get element => _element;

  set element(SpaceDynamic? value) {
    _element = value;
  }
}