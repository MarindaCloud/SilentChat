import 'package:silentchat/entity/silent_chat_entity.dart';

/**
 * @author Marinda
 * @date 2023/5/29 11:03
 * @description 用户实体类
 */
class User extends SilentChatEntity{
  int? _id;
  int? _number;
  String? _username;
  String? _password;
  String? _phone;

  User(
      {int? id,
        int? number,
        String? username,
        String? password,
        String? phone}) {
    if (id != null) {
      this._id = id;
    }
    if (number != null) {
      this._number = number;
    }
    if (username != null) {
      this._username = username;
    }
    if (password != null) {
      this._password = password;
    }
    if (phone != null) {
      this._phone = phone;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get number => _number;
  set number(int? number) => _number = number;
  String? get username => _username;
  set username(String? username) => _username = username;
  String? get password => _password;
  set password(String? password) => _password = password;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _number = json['number'];
    _username = json['username'];
    _password = json['password'];
    _phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['number'] = this._number;
    data['username'] = this._username;
    data['password'] = this._password;
    data['phone'] = this._phone;
    return data;
  }
}
