import 'package:silentchat/entity/silent_chat_entity.dart';

/**
 * @author Marinda
 * @date 2023/6/19 17:59
 * @description 群聊实体类
 */
class Group extends SilentChatEntity{
  int? _id;
  String? _name;
  String? _portrait;
  String? _description;
  int? _personMax;
  int? _adminMax;
  int? _rank;

  Group(
      {int? id,
        String? name,
        String? portrait,
        String? description,
        int? personMax,
        int? adminMax,
        int? rank}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (portrait != null) {
      this._portrait = portrait;
    }
    if (description != null) {
      this._description = description;
    }
    if (personMax != null) {
      this._personMax = personMax;
    }
    if (adminMax != null) {
      this._adminMax = adminMax;
    }
    if (rank != null) {
      this._rank = rank;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get portrait => _portrait;
  set portrait(String? portrait) => _portrait = portrait;
  String? get description => _description;
  set description(String? description) => _description = description;
  int? get personMax => _personMax;
  set personMax(int? personMax) => _personMax = personMax;
  int? get adminMax => _adminMax;
  set adminMax(int? adminMax) => _adminMax = adminMax;
  int? get rank => _rank;
  set rank(int? rank) => _rank = rank;

  Group.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _portrait = json['portrait'];
    _description = json['description'];
    _personMax = json['personMax'];
    _adminMax = json['adminMax'];
    _rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['portrait'] = this._portrait;
    data['description'] = this._description;
    data['personMax'] = this._personMax;
    data['adminMax'] = this._adminMax;
    data['rank'] = this._rank;
    return data;
  }
}