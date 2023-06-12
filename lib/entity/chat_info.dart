/**
 * @author Marinda
 * @date 2023/6/12 13:40
 * @description 聊天信息实体类
 */
class ChatInfo {
  int? _id;
  int? _sendId;
  int? _receiverId;
  int? _type;
  int? _mid;

  ChatInfo({int? id, int? sendId, int? receiverId, int? type, int? mid}) {
    if (id != null) {
      this._id = id;
    }
    if (sendId != null) {
      this._sendId = sendId;
    }
    if (receiverId != null) {
      this._receiverId = receiverId;
    }
    if (type != null) {
      this._type = type;
    }
    if (mid != null) {
      this._mid = mid;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get sendId => _sendId;
  set sendId(int? sendId) => _sendId = sendId;
  int? get receiverId => _receiverId;
  set receiverId(int? receiverId) => _receiverId = receiverId;
  int? get type => _type;
  set type(int? type) => _type = type;
  int? get mid => _mid;
  set mid(int? mid) => _mid = mid;

  ChatInfo.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _sendId = json['sendId'];
    _receiverId = json['receiverId'];
    _type = json['type'];
    _mid = json['mid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['sendId'] = this._sendId;
    data['receiverId'] = this._receiverId;
    data['type'] = this._type;
    data['mid'] = this._mid;
    return data;
  }
}