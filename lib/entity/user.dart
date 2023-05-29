/**
 * @author Marinda
 * @date 2023/5/29 11:03
 * @description 用户实体类
 */
class User {
  int? _uid;
  String? _userName;

  User({int? uid, String? userName}) {
    if (uid != null) {
      this._uid = uid;
    }
    if (userName != null) {
      this._userName = userName;
    }
  }

  int? get uid => _uid;
  set uid(int? uid) => _uid = uid;
  String? get userName => _userName;
  set userName(String? userName) => _userName = userName;

  User.fromJson(Map<String, dynamic> json) {
    _uid = json['uid'];
    _userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this._uid;
    data['userName'] = this._userName;
    return data;
  }
}