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
  String? _image;
  SpaceDynamic(
      {int? id,
        int? uid,
        String? content,
        String? device,
        String? time,
        String? image}) {
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
    if(image != null){
      this._image = image;
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
  String? get image => _image;
  set image(String? image) => _image = image;

  SpaceDynamic.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _uid = json['uid'];
    _content = json['content'];
    _device = json['device'];
    _time = json['time'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['uid'] = this._uid;
    data['content'] = this._content;
    data['device'] = this._device;
    data['time'] = this._time;
    data['image'] = this._image;
    return data;
  }
}