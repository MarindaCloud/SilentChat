/**
 * @author Marinda
 * @date 2023/5/29 11:02
 * @description 交互包
 */
class Packet {
  int? _type;
  dynamic _object;

  Packet({int? type, dynamic object}) {
    if (type != null) {
      this._type = type;
    }
    if (object != null) {
      this._object = object;
    }
  }

  int? get type => _type;
  set type(int? type) => _type = type;
  dynamic get object => _object;
  set object(dynamic object) => _object = object;

  Packet.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _object = json['object'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['object'] = this._object;
    return data;
  }
}
