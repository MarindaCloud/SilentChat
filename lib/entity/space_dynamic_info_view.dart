import 'package:silentchat/entity/space_comment_view.dart';
import 'package:silentchat/entity/space_dynamic.dart';
import 'package:silentchat/entity/space_dynamic_comment.dart';
import 'package:silentchat/entity/user.dart';

/**
 * @author Marinda
 * @date 2023/8/18 16:12
 * @description 空间动态详情视图
 */
class SpaceDynamicInfoView{
  SpaceDynamic? _element;
  List<User>? _commentLikeUserList;
  List<SpaceCommentView>? _commentViewList;
  SpaceDynamicInfoView(this._element,this._commentLikeUserList,this._commentViewList);

  List<User>? get commentLikeUserList => _commentLikeUserList;

  set commentLikeUserList(List<User>? value) {
    _commentLikeUserList = value;
  }

  SpaceDynamic?get element => _element;

  set element(SpaceDynamic? value) {
    _element = value;
  }

  List<SpaceCommentView>? get commentViewList => _commentViewList;

  set commentViewList(List<SpaceCommentView>? value) {
    _commentViewList = value;
  }
}