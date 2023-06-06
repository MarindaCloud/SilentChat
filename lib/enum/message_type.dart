/**
 * @author Marinda
 * @date 2023/6/5 11:28
 * @description 消息类型
 */
enum MessageType{
  TEXT("text"),IMAGE("image"),VOICE("voice");

  const MessageType(this.type);
  final String type;

  /*
   * @author Marinda
   * @date 2023/6/5 11:33
   * @description 根据类型获取MessageType对象
   */
  static MessageType? getMessageType(String type){
    for(MessageType element in MessageType.values){
      String value = element.type;
      if(type == value){
        return element;
      }
    }
    return null;
  }
}