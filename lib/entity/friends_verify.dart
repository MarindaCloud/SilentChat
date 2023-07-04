import 'package:silentchat/entity/verify.dart';

/**
 * @author Marinda
 * @date 2023/7/4 15:31
 * @description  朋友验证消息实体类
 */
class FriendsVerify extends Verify{
  int? _id;
  int? _uid;
  int? _tid;
  String? _message;
  DateTime? _time;
  int? _status;

  FriendsVerify(
      {int? id,
        int? uid,
        int? tid,
        String? message,
        DateTime? time,
        int? status}) {
    if (id != null) {
      this._id = id;
    }
    if (uid != null) {
      this._uid = uid;
    }
    if (tid != null) {
      this._tid = tid;
    }
    if (message != null) {
      this._message = message;
    }
    if (time != null) {
      this._time = time;
    }
    if (status != null) {
      this._status = status;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get uid => _uid;
  set uid(int? uid) => _uid = uid;
  int? get tid => _tid;
  set tid(int? tid) => _tid = tid;
  String? get message => _message;
  set message(String? message) => _message = message;
  DateTime? get time => _time;
  set time(DateTime? time) => _time = time;
  int? get status => _status;
  set status(int? status) => _status = status;

  FriendsVerify.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _uid = json['uid'];
    _tid = json['tid'];
    _message = json['message'];
    if(json["time"] !=null){
      var dt = json["time"];
      _time =  DateTime.parse(dt);
    }
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['uid'] = this._uid;
    data['tid'] = this._tid;
    data['message'] = this._message;
    data['time'] = this._time;
    data['status'] = this._status;
    return data;
  }
}