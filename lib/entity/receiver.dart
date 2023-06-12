import 'package:silentchat/common/system/logic.dart';
import 'package:silentchat/entity/UserReceiver.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/entity/silent_chat_entity.dart';
import 'package:get/get.dart';
/**
 * @author Marinda
 * @date 2023/6/12 14:58
 * @description 接收者接口
 */
abstract class Receiver {

  /*
   * @author Marinda
   * @date 2023/6/12 15:04
   * @description 获取标题
   */
  Future<SilentChatEntity> getEntity({int? uid});

  /*
   * @author Marinda
   * @date 2023/6/12 15:01
   * @description 获取消息列表
   */
  Future<List<Message>> getMessageList();


  /*
   * @author Marinda
   * @date 2023/6/12 15:44
   * @description 获取最新的消息
   */
  Future<Message?> getNewMessage({int? uid,int? receiverId});


  Future<List<int>> getReceiverList();
}