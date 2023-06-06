/**
 * @author Marinda
 * @date 2023/6/3 14:01
 * @description  聊天消息
 */
class ChatMessage {
  int? _uid;
  String? _chatMessage;

  ChatMessage({int? uid, String? chatMessage}) {
    if (uid != null) {
      this._uid = uid;
    }
    if (chatMessage != null) {
      this._chatMessage = chatMessage;
    }
  }

  int? get uid => _uid;
  set uid(int? uid) => _uid = uid;
  String? get chatMessage => _chatMessage;
  set chatMessage(String? chatMessage) => _chatMessage = chatMessage;

  ChatMessage.fromJson(Map<String, dynamic> json) {
    _uid = json['uid'];
    _chatMessage = json['chatMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this._uid;
    data['chatMessage'] = this._chatMessage;
    return data;
  }
}