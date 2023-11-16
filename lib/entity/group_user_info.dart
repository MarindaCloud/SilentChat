class GroupUserInfo {
  int? _id;
  int? _uid;
  int? _gid;
  String? _nickName;
  int? _isAdmin;

  GroupUserInfo({int? id, int? uid, int? gid, String? nickName, int? isAdmin}) {
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
    if (isAdmin != null) {
      this._isAdmin = isAdmin;
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
  int? get isAdmin => _isAdmin;
  set isAdmin(int? isAdmin) => _isAdmin = isAdmin;

  GroupUserInfo.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _uid = json['uid'];
    _gid = json['gid'];
    _nickName = json['nickName'];
    _isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['uid'] = this._uid;
    data['gid'] = this._gid;
    data['nickName'] = this._nickName;
    data['isAdmin'] = this._isAdmin;
    return data;
  }
}