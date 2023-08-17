class SpaceInfo {
  int? _id;
  int? _spaceId;
  int? _commentId;

  SpaceInfo({int? id, int? spaceId, int? commentId}) {
    if (id != null) {
      this._id = id;
    }
    if (spaceId != null) {
      this._spaceId = spaceId;
    }
    if (commentId != null) {
      this._commentId = commentId;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get spaceId => _spaceId;
  set spaceId(int? spaceId) => _spaceId = spaceId;
  int? get commentId => _commentId;
  set commentId(int? commentId) => _commentId = commentId;

  SpaceInfo.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _spaceId = json['space_id'];
    _commentId = json['comment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['space_id'] = this._spaceId;
    data['comment_id'] = this._commentId;
    return data;
  }
}