/**
 * @author Marinda
 * @date 2023/8/16 16:09
 * @description 群组包
 */
class PacketGroup {
  int? _code;
  int? _uid;
  int? _gid;
  List<int>? _receiverIdList;

  PacketGroup({int? code, int? uid, int? gid, List<int>? receiverIdList}) {
    if (code != null) {
      this._code = code;
    }
    if (uid != null) {
      this._uid = uid;
    }
    if (gid != null) {
      this._gid = gid;
    }
    if (receiverIdList != null) {
      this._receiverIdList = receiverIdList;
    }
  }

  int? get code => _code;
  set code(int? code) => _code = code;
  int? get uid => _uid;
  set uid(int? uid) => _uid = uid;
  int? get gid => _gid;
  set gid(int? gid) => _gid = gid;
  List<int>? get receiverIdList => _receiverIdList;
  set receiverIdList(List<int>? receiverIdList) =>
      _receiverIdList = receiverIdList;

  PacketGroup.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _uid = json['uid'];
    _gid = json['gid'];
    _receiverIdList = json['receiverIdList'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['uid'] = this._uid;
    data['gid'] = this._gid;
    data['receiverIdList'] = this._receiverIdList;
    return data;
  }
}