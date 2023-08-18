/**
 * @author Marinda
 * @date 2023/8/17 17:05
 * @description 空间评论详情
 */
class SpaceDynamic {
  int? _id;
  int? _uid;
  String? _content;
  String? _device;
  String? _time;
  int? _type;

  SpaceDynamic(
      {int? id,
        int? uid,
        String? content,
        String? device,
        String? time,
        int? type}) {
    if (id != null) {
      this._id = id;
    }
    if (uid != null) {
      this._uid = uid;
    }
    if (content != null) {
      this._content = content;
    }
    if (device != null) {
      this._device = device;
    }
    if (time != null) {
      this._time = time;
    }
    if (type != null) {
      this._type = type;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get uid => _uid;
  set uid(int? uid) => _uid = uid;
  String? get content => _content;
  set content(String? content) => _content = content;
  String? get device => _device;
  set device(String? device) => _device = device;
  String? get time => _time;
  set time(String? time) => _time = time;
  int? get type => _type;
  set type(int? type) => _type = type;

  SpaceDynamic.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _uid = json['uid'];
    _content = json['content'];
    _device = json['device'];
    _time = json['time'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['uid'] = this._uid;
    data['content'] = this._content;
    data['device'] = this._device;
    data['time'] = this._time;
    data['type'] = this._type;
    return data;
  }
}