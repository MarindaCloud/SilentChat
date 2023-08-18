class SpaceDynamicLike {
  int? _dynamicId;
  int? _uid;

  SpaceDynamicLike({int? dynamicId, int? uid}) {
    if (dynamicId != null) {
      this._dynamicId = dynamicId;
    }
    if (uid != null) {
      this._uid = uid;
    }
  }

  int? get dynamicId => _dynamicId;
  set dynamicId(int? dynamicId) => _dynamicId = dynamicId;
  int? get uid => _uid;
  set uid(int? uid) => _uid = uid;

  SpaceDynamicLike.fromJson(Map<String, dynamic> json) {
    _dynamicId = json['dynamic_id'];
    _uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dynamic_id'] = this._dynamicId;
    data['uid'] = this._uid;
    return data;
  }
}