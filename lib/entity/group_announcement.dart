/**
 * @author Marinda
 * @date 2023/10/8 14:16
 * @description 群公告
 */
class GroupAnnouncement {
  int? _id;
  int? _gid;
  String? _content;
  String? _time;
  int? _owner;

  GroupAnnouncement(
      {int? id, int? gid, String? content, String? time, int? owner}) {
    if (id != null) {
      this._id = id;
    }
    if (gid != null) {
      this._gid = gid;
    }
    if (content != null) {
      this._content = content;
    }
    if (time != null) {
      this._time = time;
    }
    if (owner != null) {
      this._owner = owner;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get gid => _gid;
  set gid(int? gid) => _gid = gid;
  String? get content => _content;
  set content(String? content) => _content = content;
  String? get time => _time;
  set time(String? time) => _time = time;
  int? get owner => _owner;
  set owner(int? owner) => _owner = owner;

  GroupAnnouncement.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _gid = json['gid'];
    _content = json['content'];
    _time = json['time'];
    _owner = json['owner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['gid'] = this._gid;
    data['content'] = this._content;
    data['time'] = this._time;
    data['owner'] = this._owner;
    return data;
  }
}