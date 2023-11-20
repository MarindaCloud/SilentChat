import 'package:silentchat/entity/space_dynamic_comment.dart';
import 'package:silentchat/entity/user.dart';

/**
 * @author Marinda
 * @date 2023/11/20 15:02
 * @description 空间评论视图
 */
class SpaceCommentView{
  User? _user;
  SpaceDynamicComment? _comment;

  SpaceCommentView(this._user,this._comment);

  SpaceDynamicComment? get comment => _comment;

  set comment(SpaceDynamicComment? value) {
    _comment = value;
  }

  User? get user => _user;

  set user(User? value) {
    _user = value;
  }
}