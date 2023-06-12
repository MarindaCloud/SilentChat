/**
 * @author Marinda
 * @date 2023/6/5 11:28
 * @description 消息类型
 */
enum MessageType{
  TEXT(1),IMAGE(2),VOICE(3),FILE(4);

  const MessageType(this.type);
  final int type;

  /*
   * @author Marinda
   * @date 2023/6/5 11:33
   * @description 根据类型获取MessageType对象
   */
  static MessageType? getMessageType(int type){
    for(MessageType element in MessageType.values){
      int value = element.type;
      if(type == value){
        return element;
      }
    }
    return null;
  }
}