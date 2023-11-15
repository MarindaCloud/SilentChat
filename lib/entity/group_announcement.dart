/**
 * @author Marinda
 * @date 2023/11/15 16:22
 * @description 群公告
 */
class GroupAnnouncement {
  int? _id;
  int? _gid;
  String? _content;
  String? _time;
  String? _image;
  int? _owner;
  int? _isTop;

  GroupAnnouncement(
      {int? id,
        int? gid,
        String? content,
        String? time,
        String? image,
        int? owner,
        int? isTop}) {
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
    if (image != null) {
      this._image = image;
    }
    if (owner != null) {
      this._owner = owner;
    }
    if (isTop != null) {
      this._isTop = isTop;
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
  String? get image => _image;
  set image(String? image) => _image = image;
  int? get owner => _owner;
  set owner(int? owner) => _owner = owner;
  int? get isTop => _isTop;
  set isTop(int? isTop) => _isTop = isTop;

  GroupAnnouncement.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _gid = json['gid'];
    _content = json['content'];
    _time = json['time'];
    _image = json['image'];
    _owner = json['owner'];
    _isTop = json['isTop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['gid'] = this._gid;
    data['content'] = this._content;
    data['time'] = this._time;
    data['image'] = this._image;
    data['owner'] = this._owner;
    data['isTop'] = this._isTop;
    return data;
  }
}