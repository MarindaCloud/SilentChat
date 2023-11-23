class SpaceUserInfo {
  int? _id;
  int? _uid;
  int? _spaceId;

  SpaceUserInfo({int? id, int? uid, int? spaceId}) {
    if (id != null) {
      this._id = id;
    }
    if (uid != null) {
      this._uid = uid;
    }
    if (spaceId != null) {
      this._spaceId = spaceId;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get uid => _uid;
  set uid(int? uid) => _uid = uid;
  int? get spaceId => _spaceId;
  set spaceId(int? spaceId) => _spaceId = spaceId;

  SpaceUserInfo.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _uid = json['uid'];
    _spaceId = json['spaceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['uid'] = this._uid;
    data['spaceId'] = this._spaceId;
    return data;
  }
}