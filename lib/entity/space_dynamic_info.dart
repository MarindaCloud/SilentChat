class SpaceInfo {
  int? _id;
  int? _spaceId;
  int? _dynamicId;

  SpaceInfo({int? id, int? spaceId, int? dynamicId}) {
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

  SpaceInfo.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _spaceId = json['space_id'];
    _dynamicId = json['dynamic_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['space_id'] = this._spaceId;
    data['dynamic_id'] = this._dynamicId;
    return data;
  }
}