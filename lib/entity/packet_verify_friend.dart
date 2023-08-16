/**
 * @author Marinda
 * @date 2023/8/16 11:18
 * @description 朋友验证消息包
 */
class PacketVerifyFriend {
  int? _code;
  int? _uid;
  int? _receiverId;
  String? _verifyMsg;

  PacketVerifyFriend(
      {int? code, int? uid, int? receiverId, String? verifyMsg}) {
    if (code != null) {
      this._code = code;
    }
    if (uid != null) {
      this._uid = uid;
    }
    if (receiverId != null) {
      this._receiverId = receiverId;
    }
    if (verifyMsg != null) {
      this._verifyMsg = verifyMsg;
    }
  }

  int? get code => _code;
  set code(int? code) => _code = code;
  int? get uid => _uid;
  set uid(int? uid) => _uid = uid;
  int? get receiverId => _receiverId;
  set receiverId(int? receiverId) => _receiverId = receiverId;
  String? get verifyMsg => _verifyMsg;
  set verifyMsg(String? verifyMsg) => _verifyMsg = verifyMsg;

  PacketVerifyFriend.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _uid = json['uid'];
    _receiverId = json['receiverId'];
    _verifyMsg = json['verifyMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['uid'] = this._uid;
    data['receiverId'] = this._receiverId;
    data['verifyMsg'] = this._verifyMsg;
    return data;
  }
}