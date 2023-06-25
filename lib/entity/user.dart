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
  int? _sex;
  DateTime? _birthday;
  String? _signature;
  String? _location;

  User(
      {int? id,
        int? number,
        String? username,
        String? password,
        String? phone,
        int? sex,
        DateTime? birthday,
        String? signature,
        String? location}) {
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
    if (sex != null) {
      this._sex = sex;
    }
    if (birthday != null) {
      this._birthday = birthday;
    }
    if (signature != null) {
      this._signature = signature;
    }
    if (location != null) {
      this._location = location;
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
  int? get sex => _sex;
  set sex(int? sex) => _sex = sex;
  DateTime? get birthday => _birthday;
  set birthday(DateTime? birthday) => _birthday = birthday;
  String? get signature => _signature;
  set signature(String? signature) => _signature = signature;
  String? get location => _location;
  set location(String? location) => _location = location;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _number = json['number'];
    _username = json['username'];
    _password = json['password'];
    _phone = json['phone'];
    _sex = json['sex'];
    if(json["birthday"] != null){
      _birthday = DateTime.parse(json["birthday"]);
    }
    _signature = json['signature'];
    _location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['number'] = this._number;
    data['username'] = this._username;
    data['password'] = this._password;
    data['phone'] = this._phone;
    data['sex'] = this._sex;
    data['birthday'] = this._birthday;
    data['signature'] = this._signature;
    data['location'] = this._location;
    return data;
  }
}