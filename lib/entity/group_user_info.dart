/**
 * @author Marinda
 * @date 2023/6/19 18:05
 * @description 群聊用户信息
 */
class GroupUserInfo {
  int? _id;
  int? _uid;
  int? _gid;
  String? _nickName;

  GroupUserInfo({int? id, int? uid, int? gid, String? nickName}) {
    if (id != null) {
      this._id = id;
    }
    if (uid != null) {
      this._uid = uid;
    }
    if (gid != null) {
      this._gid = gid;
    }
    if (nickName != null) {
      this._nickName = nickName;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get uid => _uid;
  set uid(int? uid) => _uid = uid;
  int? get gid => _gid;
  set gid(int? gid) => _gid = gid;
  String? get nickName => _nickName;
  set nickName(String? nickName) => _nickName = nickName;

  GroupUserInfo.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _uid = json['uid'];
    _gid = json['gid'];
    _nickName = json['nickName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['uid'] = this._uid;
    data['gid'] = this._gid;
    data['nickName'] = this._nickName;
    return data;
  }
}