/**
 * @author Marinda
 * @date 2023/5/29 11:03
 * @description 用户实体类
 */
class User {
  int? _id;
  String? _userName;
  String? _password;
  int? _phone;

  User({int? id, String? userName, String? password, int? phone}) {
    if (id != null) {
      this._id = id;
    }
    if (userName != null) {
      this._userName = userName;
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
  String? get userName => _userName;
  set userName(String? userName) => _userName = userName;
  String? get password => _password;
  set password(String? password) => _password = password;
  int? get phone => _phone;
  set phone(int? phone) => _phone = phone;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userName = json['userName'];
    _password = json['password'];
    _phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['userName'] = this._userName;
    data['password'] = this._password;
    data['phone'] = this._phone;
    return data;
  }
}