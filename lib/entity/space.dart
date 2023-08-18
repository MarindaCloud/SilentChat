class Space {
  int? _id;
  int? _uid;
  String? _name;
  int? _exp;
  int? _level;

  Space({int? id, int? uid, String? name, int? exp, int? level}) {
    if (id != null) {
      this._id = id;
    }
    if (uid != null) {
      this._uid = uid;
    }
    if (name != null) {
      this._name = name;
    }
    if (exp != null) {
      this._exp = exp;
    }
    if (level != null) {
      this._level = level;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get uid => _uid;
  set uid(int? uid) => _uid = uid;
  String? get name => _name;
  set name(String? name) => _name = name;
  int? get exp => _exp;
  set exp(int? exp) => _exp = exp;
  int? get level => _level;
  set level(int? level) => _level = level;

  Space.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _uid = json['uid'];
    _name = json['name'];
    _exp = json['exp'];
    _level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['uid'] = this._uid;
    data['name'] = this._name;
    data['exp'] = this._exp;
    data['level'] = this._level;
    return data;
  }
}