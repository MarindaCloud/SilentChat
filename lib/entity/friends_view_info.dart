import 'package:silentchat/entity/user.dart';

/**
 * @author Marinda
 * @date 2023/7/6 13:50
 * @description 朋友信息视图
 */
class FriendsViewInfo {
  User? user;
  String? letter;

  FriendsViewInfo({this.user,this.letter});

  get getUser => user;
  get getLetter => letter;


  set setUser(User? user) => this.user = user;
  set setLetter(String? letter) => this.letter = letter;
}