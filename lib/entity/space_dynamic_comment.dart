/**
 * @author Marinda
 * @date 2023/11/20 11:38
 * @description 空间动态评论
 */
class SpaceDynamicComment {
  int? _id;
  int? _dynamicId;
  int? _uid;
  String? _comment;

  SpaceDynamicComment({int? id, int? dynamicId, int? uid, String? comment}) {
    if (id != null) {
      this._id = id;
    }
    if (dynamicId != null) {
      this._dynamicId = dynamicId;
    }
    if (uid != null) {
      this._uid = uid;
    }
    if (comment != null) {
      this._comment = comment;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get dynamicId => _dynamicId;
  set dynamicId(int? dynamicId) => _dynamicId = dynamicId;
  int? get uid => _uid;
  set uid(int? uid) => _uid = uid;
  String? get comment => _comment;
  set comment(String? comment) => _comment = comment;

  SpaceDynamicComment.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _dynamicId = json['dynamicId'];
    _uid = json['uid'];
    _comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['dynamicId'] = this._dynamicId;
    data['uid'] = this._uid;
    data['comment'] = this._comment;
    return data;
  }
}

