/**
 * @author Marinda
 * @date 2023/9/1 16:49
 * @description 账号历史
 */
class AccountHistory {
  String? _username;
  String? _password;
  String? _portrait;

  AccountHistory({String? username, String? password, String? portrait}) {
    if (username != null) {
      this._username = username;
    }
    if (password != null) {
      this._password = password;
    }
    if (portrait != null) {
      this._portrait = portrait;
    }
  }

  String? get username => _username;
  set username(String? username) => _username = username;
  String? get password => _password;
  set password(String? password) => _password = password;
  String? get portrait => _portrait;
  set portrait(String? portrait) => _portrait = portrait;

  AccountHistory.fromJson(Map<String, dynamic> json) {
    _username = json['username'];
    _password = json['password'];
    _portrait = json['portrait'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this._username;
    data['password'] = this._password;
    data['portrait'] = this._portrait;
    return data;
  }
}