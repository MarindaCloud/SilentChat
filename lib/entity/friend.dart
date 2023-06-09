/**
 * @author Marinda
 * @date 2023/6/9 18:04
 * @description 朋友实体类
 */
class Friend {
  int? _id;
  int? _uid;
  int? _fid;

  Friend({int? id, int? uid, int? fid}) {
    if (id != null) {
      this._id = id;
    }
    if (uid != null) {
      this._uid = uid;
    }
    if (fid != null) {
      this._fid = fid;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get uid => _uid;
  set uid(int? uid) => _uid = uid;
  int? get fid => _fid;
  set fid(int? fid) => _fid = fid;

  Friend.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _uid = json['uid'];
    _fid = json['fid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['uid'] = this._uid;
    data['fid'] = this._fid;
    return data;
  }
}