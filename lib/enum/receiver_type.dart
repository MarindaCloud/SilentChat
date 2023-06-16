/**
 * @author Marinda
 * @date 2023/6/16 16:41
 * @description 聊天消息类型 1、联系人 2群聊
 */
enum ReceiverType{
  CONTACT(1),GROUP(2);

  final int type;
  const ReceiverType(this.type);

  /*
   * @author Marinda
   * @date 2023/6/5 11:33
   * @description 根据类型获取MessageType对象
   */
  static ReceiverType? getMessageType(int type){
    for(ReceiverType element in ReceiverType.values){
      int value = element.type;
      if(type == value){
        return element;
      }
    }
    return null;
  }
}