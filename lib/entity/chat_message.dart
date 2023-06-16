import 'package:silentchat/enum/message_type.dart';
import 'package:silentchat/enum/receiver_type.dart';

/**
 * @author Marinda
 * @date 2023/6/3 14:01
 * @description  聊天消息
 */
class ChatMessage {
  int? _uid;
  String? _chatMessage;
  ReceiverType? _receiverType;
  int? _receiverId;

  ChatMessage({int? uid, String? chatMessage,ReceiverType? receiverType,int? receiverId}) {
    if (uid != null) {
      this._uid = uid;
    }
    if (chatMessage != null) {
      this._chatMessage = chatMessage;
    }
    if(receiverType != null){
      this._receiverType = receiverType;
    }
    if(receiverId != null){
      this._receiverId = receiverId;
    }
  }

  int? get uid => _uid;
  set uid(int? uid) => _uid = uid;
  String? get chatMessage => _chatMessage;
  set chatMessage(String? chatMessage) => _chatMessage = chatMessage;


  ReceiverType? get receiverType => _receiverType;

  set receiverType(ReceiverType? value) {
    _receiverType = value;
  }

  ChatMessage.fromJson(Map<String, dynamic> json) {
    _uid = json['uid'];
    _chatMessage = json['chatMessage'];
    if(json["receiverType"] != null){
      _receiverType = ReceiverType.getMessageType(json["receiverType"]);
    }
    if(json["receiverId"] != null){
      _receiverId = json["receiverId"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this._uid;
    data['chatMessage'] = this._chatMessage;
    data["receiverType"] = this._receiverType?.type;
    data["receiverId"] = this.receiverId;
    return data;
  }

  int? get receiverId => _receiverId;

  set receiverId(int? value) {
    _receiverId = value;
  }
}