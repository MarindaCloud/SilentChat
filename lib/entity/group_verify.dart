class GroupVerify {
  int? _id;
  int? _uid;
  int? _gid;
  String? _message;
  String? _time;
  int? _status;

  GroupVerify(
      {int? id,
        int? uid,
        int? gid,
        String? message,
        String? time,
        int? status}) {
    if (id != null) {
      this._id = id;
    }
    if (uid != null) {
      this._uid = uid;
    }
    if (gid != null) {
      this._gid = gid;
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
  int? get gid => _gid;
  set gid(int? gid) => _gid = gid;
  String? get message => _message;
  set message(String? message) => _message = message;
  String? get time => _time;
  set time(String? time) => _time = time;
  int? get status => _status;
  set status(int? status) => _status = status;

  GroupVerify.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _uid = json['uid'];
    _gid = json['gid'];
    _message = json['message'];
    _time = json['time'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['uid'] = this._uid;
    data['gid'] = this._gid;
    data['message'] = this._message;
    data['time'] = this._time;
    data['status'] = this._status;
    return data;
  }
}

