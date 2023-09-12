import 'package:silentchat/util/date_time_util.dart';

class Message {
  int? _id;
  String? _content;
  int? _type;
  String? _expandAddress;
  DateTime? _time;

  Message({int? id,String? content, int? type, String? expandAddress, DateTime? time}) {
    if (content != null) {
      this._content = content;
    }
    if (type != null) {
      this._type = type;
    }
    if (expandAddress != null) {
      this._expandAddress = expandAddress;
    }
    if (time != null) {
      this._time = time;
    }
    if(id != null){
      this.id = id;
    }
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          _id == other._id &&
          _content == other._content &&
          _type == other._type &&
          _expandAddress == other._expandAddress &&
          _time == other._time;

  @override
  int get hashCode =>
      _id.hashCode ^
      _content.hashCode ^
      _type.hashCode ^
      _expandAddress.hashCode ^
      _time.hashCode;

  int? get id => _id;
  set id(int? id) => _id = id;

  String? get content => _content;
  set content(String? content) => _content = content;
  int? get type => _type;
  set type(int? type) => _type = type;
  String? get expandAddress => _expandAddress;
  set expandAddress(String? expandAddress) => _expandAddress = expandAddress;
  DateTime? get time => _time;
  set time(DateTime? time) => _time = time;

  Message.fromJson(Map<String, dynamic> json) {
    _content = json['content'];
    _type = json['type'];
    _id = json['id'];
    _expandAddress = json['expandAddress'];
    _time = DateTime.parse(json["time"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this._content;
    data['type'] = this._type;
    data['id'] = this._id;
    data['expandAddress'] = this._expandAddress;
    String time = DateTimeUtil.formatDateTime(this._time!,format: DateTimeUtil.ymdhns);
    data["time"] = time;
    return data;
  }
}