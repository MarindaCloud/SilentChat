import 'package:silentchat/enum/message_type.dart';

/**
 * @author Marinda
 * @date 2023/6/5 11:28
 * @description 聊天记录数据
 */
class ChatRecordData {
  //目标uid
  int? _targetId;
  String? _message;
  MessageType? _messageType;
  String? _portrait;
  DateTime? _time;


  ChatRecordData(
      {int? targetId,
        String? message,
        MessageType? messageType,
        String? portrait,
        DateTime? time}) {
    if (targetId != null) {
      this._targetId = targetId;
    }
    if (message != null) {
      this._message = message;
    }
    if (messageType != null) {
      this._messageType = messageType;
    }
    if (portrait != null) {
      this._portrait = portrait;
    }
    if (time != null) {
      this._time = time;
    }
  }

  int? get targetId => _targetId;
  set targetId(int? targetId) => _targetId = targetId;
  String? get message => _message;
  set message(String? message) => _message = message;
  MessageType? get messageType => _messageType;
  set messageType(MessageType? messageType) => _messageType = messageType;
  String? get portrait => _portrait;
  set portrait(String? portrait) => _portrait = portrait;
  DateTime? get time => _time;
  set time(DateTime? time) => _time = time;

  ChatRecordData.fromJson(Map<String, dynamic> json) {
    if(json["target_id"] != null){
      _targetId = json['target_id'];
    }
    if(json["message"] != null){
      _message = json["message"];
    }
    if(json["message_type"] != null){
      _messageType = MessageType.getMessageType(json["message_type"]);
    }
    if(json["portrait"] != null){
      _portrait = json["portrait"];
    }
    if(json["time"] != null){
      var targetDateTime = DateTime.parse(json["time"]);
      _time = targetDateTime;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['target_id'] = this._targetId;
    data['message'] = this._message;
    data['message_type'] = this._messageType?.type;
    data['portrait'] = this._portrait;
    data['time'] = this._time.toString();
    return data;
  }
}