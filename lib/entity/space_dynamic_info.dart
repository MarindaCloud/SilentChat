class SpaceDynamicInfo {
  int? _id;
  int? _spaceId;
  int? _dynamicId;

  SpaceDynamicInfo({int? id, int? spaceId, int? dynamicId}) {
    if (id != null) {
      this._id = id;
    }
    if (spaceId != null) {
      this._spaceId = spaceId;
    }
    if (dynamicId != null) {
      this._dynamicId = dynamicId;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get spaceId => _spaceId;
  set spaceId(int? spaceId) => _spaceId = spaceId;
  int? get dynamicId => _dynamicId;
  set dynamicId(int? dynamicId) => _dynamicId = dynamicId;

  SpaceDynamicInfo.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _spaceId = json['spaceId'];
    _dynamicId = json['dynamicId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['spaceId'] = this._spaceId;
    data['dynamicId'] = this._dynamicId;
    return data;
  }
}