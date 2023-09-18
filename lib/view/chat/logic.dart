import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/emoji.dart';
import 'package:silentchat/controller/system/logic.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/db/dao/record_message_dao.dart';
import 'package:silentchat/db/db_manager.dart';
import 'package:silentchat/entity/app_page.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/user_receiver.dart';
import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/entity/chat_info.dart';
import 'package:silentchat/entity/chat_message.dart';
import 'package:silentchat/entity/chat_record_data.dart';
import 'package:silentchat/entity/message.dart';
import 'package:silentchat/entity/packet.dart';
import 'package:silentchat/entity/receiver.dart';
import 'package:silentchat/entity/user.dart';
import 'package:silentchat/enum/message_type.dart';
import 'package:silentchat/enum/receiver_type.dart';
import 'package:silentchat/network/api/group_api.dart';
import 'package:silentchat/network/api/message_api.dart';
import 'package:silentchat/network/api/user_api.dart';
import 'package:silentchat/socket/socket_handle.dart';
import 'package:silentchat/util/date_time_util.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silentchat/util/log.dart';
import 'state.dart';
import 'package:flutter_sound/flutter_sound.dart';
import "package:permission_handler/permission_handler.dart";
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;



class ChatLogic extends GetxController with GetTickerProviderStateMixin{
  final ChatState state = ChatState();
  final systemLogic = Get.find<SystemLogic>();
  final systemState = Get.find<SystemLogic>().state;
  final userLogic = Get.find<UserLogic>();
  final userState = Get.find<UserLogic>().state;
  AnimationController? imageOpacity;
  Animation<double>? imageOpacityTween;

  @override
  void onInit() async{
    imageOpacity = AnimationController(vsync: this,duration: Duration(seconds: 1));
    imageOpacityTween = Tween<double>(begin: 0,end: 1).animate(imageOpacity!);
    if(Get.arguments == null ) return;
    Map<String,int> args = Get.arguments;
    Log.i('参数：${args}');
    int type = args["type"] ?? -1;
    int id = args["id"] ?? -1;
    state.receiverId.value = id;
    state.type.value = type;
    await initMessageList();
    getTitle(id, type);
    await initRecordHistory();
    initChatRecordDataList();
    state.socketHandle = Get.find<SocketHandle>();
    final ImagePicker picker = ImagePicker();
    state.picker = picker;
    state.animatedController = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    state.fadeValue = Tween<double>(begin: 0,end: 1).animate(state.animatedController!);
    await initSoundSetting();
  }

  /*
   * @author Marinda
   * @date 2023/6/26 15:25
   * @description 初始化声音设置
   */
  initSoundSetting() async{
    await state.flutterSoundPlayer.openPlayer();
    await state.recordSound.openRecorder();
  }

  /*
   * @author Marinda
   * @date 2023/9/12 17:51
   * @description
   */
  initMessageList() async{
    List<Message> messageList = [];
    if(state.type.value == 1){
      List msgList = await MessageAPI.selectUserMessageList(userState.uid.value, state.receiverId.value);
        if(msgList.isEmpty){
          messageList = [];
        }else{
          messageList = msgList as List<Message>;
        }
    }else{
      List msgList = await MessageAPI.selectGroupMessageList(state.receiverId.value);
      if(msgList.isEmpty){
        messageList = [];
      }else{
        messageList = msgList as List<Message>;
      }
    }
    state.messageList.value = messageList;
  }
  /*
   * @author Marinda
   * @date 2023/9/12 16:44
   * @description 初始化记录历史
   */
  initRecordHistory() async{
    final db = DBManager();
    RecordMessageDao dao = RecordMessageDao(db);
    RecordMessageData? history = await dao.selectReceiverRecordMessageList(state.receiverId.value);
    Log.i("history: ${history}");
    if(history == null){
      //和该目标的消息列表不为空
      if(state.messageList.isNotEmpty){
        //第一次打开初始化加入所有消息记录
        RecordMessageCompanion recordMessageCompanion = RecordMessageCompanion(
            receiverId: drift.Value(state.receiverId.value),
            message: drift.Value(json.encode(state.messageList)));
        await dao.insertRecordMessage(recordMessageCompanion);
      }
     }
    //储存缓存中未存在的消息列表
    List<Message> cloneMessageList = [];
    //都不为空
    if(history != null && state.messageList.isNotEmpty){
      List messageElement = json.decode(history.message);
      List<Message> messageList = messageElement.map((e) => Message.fromJson(e)).toList();
      cloneMessageList.addAll(messageList);
      for(Message element in state.messageList){
          if(validMessageContainsList(element, messageList)){
            continue;
          }
          cloneMessageList.add(element);
        }
      var jsonMap = history.toJson();
      jsonMap["message"] = json.encode(cloneMessageList);
      RecordMessageData newRecordMessageData = RecordMessageData.fromJson(jsonMap);
      await dao.updateRecordMessage(newRecordMessageData);
      Log.i("修改完毕！");
      }
    }

    /*
     * @author Marinda
     * @date 2023/9/12 17:26
     * @description 查询消息列表
     */
    bool validMessageContainsList(Message message,List<Message> messageList){
      for(var element in messageList){
        if(element.id == message.id){
          return true;
        }
      }
      return false;
    }

  /*
   * @author Marinda
   * @date 2023/6/26 15:30
   * @description 关闭声音配置
   */
  closeSoundSetting() async{
    await state.flutterSoundPlayer.closePlayer();
    await state.recordSound.closeRecorder();
  }


  @override
  void onClose() async{
    await closeSoundSetting();
  }

  /*
   * @author Marinda
   * @date 2023/6/26 15:31
   * @description 录音
   */
  void recordSound() async{
    PermissionStatus status = await Permission.microphone.request();
    //权限校验
    if (status != PermissionStatus.granted) throw RecordingPermissionException("麦克风权限未授权！");
    var dir = await getApplicationDocumentsDirectory();
    Uuid uuid = Uuid();
    String filePath = p.join(dir.path,uuid.v4());
    Log.i("录音保存的位置：${filePath}");
    await state.recordSound.startRecorder(toFile: filePath,codec: Codec.mp3);
  }

  /*
   * @author Marinda
   * @date 2023/6/26 15:33
   * @description
   */
  void stopRecordSound() async{
    await state.recordSound.closeRecorder();
  }

  /*
   * @author Marinda
   * @date 2023/9/14 18:02
   * @description 修改好友信息
   */

  toEditFriendsInfo() async{
    //用户
    if(state.type.value == 1){
      User user = await UserAPI.selectByUid(state.receiverId.value);
      await Get.toNamed(AppPage.editFriendsInfo,arguments: user);
      state.title.value = userState.notesMap[state.receiverId.value] ?? "";
      userState.notesMap.refresh();
    }else{
      Group group = await GroupAPI.selectById(state.receiverId.value);
    //  群组
      await Get.toNamed(AppPage.editGroupsInfo,arguments: group);
    }

  }

  /*
   * @author Marinda
   * @date 2023/6/14 18:33
   * @description 获取title
   */
  getTitle(int id,int type) async{
    String title = "";
    switch(type){
      case 1:
        //  用户
        String username = userState.notesMap[id] ?? "";
        title = username;
        break;
      case 2:
        Group group = await GroupAPI.selectById(id);
        String name = group.name ?? "";
        title = name;
        break;
    }
    state.title.value = title;
  }


  /*
   * @author Marinda
   * @date 2023/6/19 15:37
   * @description 用来构建聊天子控件
   */
  Widget buildSubWidget(){
    Widget widget = Container();
    switch(state.subChildType.value){
      case "luyin":
        //录音
      widget = Center(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 50.rpx),
          child: Center(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 50.rpx,
                  ),
                  Container(
                    child: Text("按住说话",
                      style: TextStyle(
                          color: Colors.grey),),
                  ),
                  SizedBox(
                    height: 100.rpx,
                  ),
                  InkWell(
                    onLongPress: (){
                      Log.i("录音中");
                      recordSound();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius
                                .circular(10000),
                            color: Colors.blue
                        ),
                        width: 300.rpx,
                        height: 300.rpx,
                        child: Center(child: Container(
                          width: 200.rpx,
                          height: 200.rpx,
                          child: Image.asset(
                            "assets/icon/luyin.png",
                            color: Colors.white,
                            fit: BoxFit.cover,),
                        ),)
                    ),
                  ),
                  //
                  Container(
                    height: 100.rpx,
                  )
                ],
              ),
            ),
          ),
        ),
      );
        break;
      case "emote":
        //表情
      widget = Container(
        height: 200,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 50.rpx),
        child: EmojiCommon.instance().buildEmoji(6,cbFunction: chooseEmoji)
        );
        break;
    }
    return widget;
  }


  /*
   * @author Marinda
   * @date 2023/6/5 14:09
   * @description 初始化聊天记录信息列表
   */
  initChatRecordDataList() async{
    final db = DBManager();
    RecordMessageDao dao = RecordMessageDao(db);
    //缓存记录消息列表
    var cacheRecordMessage = await dao.selectReceiverRecordMessageList(state.receiverId.value);
    List<Message> messageList = [];

    if(cacheRecordMessage != null){
      List messageCacheList = json.decode(cacheRecordMessage.message) as List;
      //消息列表
      messageList = messageCacheList.map((e) => Message.fromJson(e)).toList();
    }

    List<ChatRecordData> list = [];
    int id = state.receiverId.value;
    int type = state.type.value;
    int uid = userState.user.value.id ?? 0;
    Log.i("当前聊天id: ${id},类型: ${type}");
    //用户缓存列表
    List<User> cacheUserList = [];
    //用户
    if(type == 1){
      //获取聊天详情
      List<ChatInfo> chatInfoList = await MessageAPI.selectUserChatInfo();
      List<ChatInfo> filterTargetChatInfoList = chatInfoList.where((element) => element.sendId == uid && element.receiverId == id && element.type == 1 || element.sendId == id && element.receiverId == uid && element.type == 1).toList();

      for(var message in messageList){
          int mid = message.id ?? -1;
          ChatInfo chatInfo = filterTargetChatInfoList.firstWhere((element) => element.mid == mid);
          int sendId = chatInfo.sendId ?? -1;
          User user = User();
          String portrait = "";
          var cacheUser = cacheUserList.firstWhereOrNull((element) => element.id == sendId);
          if(cacheUser != null){
            portrait = cacheUser?.portrait ?? "";
          }else{
            user = await UserAPI.selectByUid(sendId);
            portrait = user.portrait ?? "";
          }
          DateTime dt = message.time!;
          int type = message.type!;
          String content = message.content ?? "";
          MessageType messageType = MessageType.getMessageType(type)!;
          ChatRecordData chatRecordData = ChatRecordData(sendId: sendId,targetId: mid,time: dt,messageType: messageType,portrait: portrait,message: content,expandAddress: message.expandAddress);
          list.add(chatRecordData);
          cacheUserList.add(user);
      }
    }else{
      //群聊
      int groupId = state.receiverId.value;
      List<ChatInfo> chatInfoList = await MessageAPI.selectGroupChatInfo(groupId);
      Group group = await GroupAPI.selectById(groupId);
      for(var message in messageList){
        ChatInfo? chatInfo = chatInfoList.firstWhereOrNull((element) => element.mid == message.id);
        if(chatInfo != null){
          int sendId = chatInfo.sendId ?? 0;
          int mid = message.id ?? 0;
          DateTime dt = message.time!;
          int type = message.type!;
          String portrait = "";
          var cacheUser = cacheUserList.firstWhereOrNull((element) => element.id == sendId);
          if(cacheUser != null){
            portrait = cacheUser?.portrait ?? "";
          }else{
            cacheUser = await UserAPI.selectByUid(sendId);
            portrait = cacheUser?.portrait ?? "";
          }
          String content = message.content ?? "";
          MessageType messageType = MessageType.getMessageType(type)!;
          ChatRecordData chatRecordData = ChatRecordData(sendId: sendId,targetId: mid,time: dt,messageType: messageType,portrait: portrait,message: content);
          list.add(chatRecordData);
          cacheUserList.add(cacheUser ?? User());
        }

      }
    }
    state.chatRecordList.value = list;
    sortRecordInfo();
  }

  /*
   * @author Marinda
   * @date 2023/6/19 14:43
   * @description 选择emoji表情
   */
  chooseEmoji(String emote){
    TextSelection messageSelection = state.messageController.selection;
    String text = state.messageController.text;
    //如果为空则直接添加即可！
    if(text == ""){
      state.messageController.text +=emote;
      TextSelection textSelection = TextSelection.collapsed(offset: emote.length);
      state.messageController.selection = textSelection;
      return;
    }
    String newText = text.replaceRange(messageSelection.start, messageSelection.end, emote);
    state.messageController.text = newText;
    int endOffset = messageSelection.start + emote.length;
    TextSelection textSelection = TextSelection.collapsed(offset: endOffset);
    state.messageController.selection = textSelection;
    Log.i("当前光标位置：${endOffset}");
  }

  /*
   * @author Marinda
   * @date 2023/6/5 15:00
   * @description 排序记录信息
   * 因为每个消息他们发送的时间段都不一致
   * 而正常情况下也不会每一个时间段显示当条聊天记录
   * 所以我们需要对它进行记录排序，指定一个时间区间范围，整合成一个Map用来储存记录信息
   * 以下时间区间段为：每10分钟为一个区间，并且Map的key为最早的格式
   */
  sortRecordInfo(){
    Map<String,List<ChatRecordData>> recordMap = {};
    Map<DateTime,List<DateTime>> timeMap = {};
    List<DateTime> dateTimeList = state.chatRecordList.map((element) => element.time!).toList();

    List<DateTime> cloneDateTime = [];
    cloneDateTime.addAll(dateTimeList);
    Log.i("当前所有聊天信息时间: ${dateTimeList}");
    //遍历克隆的所有时间 跟当前传递的时间比较，如果时间间隔相差不超过10分钟则以最早的key为主
    for(DateTime startTime in cloneDateTime){
      List<DateTime> timeList = DateTimeUtil.getDateTimeInterval(startTime, dateTimeList, Duration(minutes: 10));
      Log.i("当前时间: ${startTime},符合条件的列表: ${timeList}");
      //如果不存在这个key
      if(!timeMap.containsKey(startTime)){
      //  检查一下日期缓存中是否有存过这条日期
        if(validTimeExists(startTime, timeMap)){
          continue;
        }
        timeMap[startTime] = timeList;
      }
    }

    // 首次排序Time位置
    List<MapEntry<DateTime, List<DateTime>>> sortedEntries = timeMap.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    Map<DateTime,List<DateTime>> sortTime = Map.fromEntries(sortedEntries);

    List<ChatRecordData> cacheList = [];
    Log.i("时间Map缓存数据：${timeMap}");
    Log.i("排序后的时间缓存：${sortTime.keys.toList()}");

    Map<DateTime,List<ChatRecordData>> timeCacheMap = {};
    //  遍历所有聊天列表数据
    for(ChatRecordData recordData in state.chatRecordList){
      DateTime targetTime = recordData.time!;
      //校验日期缓存的map中是否存在这个时间
      if(sortTime.containsKey(targetTime)){
        // String chatRecordWeekDataString = DateTimeUtil.formatWeekDateTime(targetTime);
        //符合该条聊天记录区间的所有聊天信息
        List<ChatRecordData> subChatRecordList = state.chatRecordList.where((element){
          List<DateTime> timeList = sortTime[targetTime] ?? [];
          return timeList.contains(element.time);
        }).toList();

        List<ChatRecordData> tempList = [];
        for(var ele in subChatRecordList){
          //如果缓存中存在则跳出
          if(cacheList.contains(ele)){
            continue;
          }
          tempList.add(ele);
        }
        cacheList.addAll(tempList);
        timeCacheMap[targetTime] = tempList;
      }
    }
    // 转化为视图对象后再次排序Time
    List<MapEntry<DateTime, List<ChatRecordData>>> sortedTimeCache = timeCacheMap.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    Map<DateTime,List<ChatRecordData>> sortCacheTime = Map.fromEntries(sortedTimeCache);
    //转化
    sortCacheTime.forEach((key, value) {
      String formatKey = "";
      //如果超过七天则显示全日期
      if(DateTime.now().difference(key).inDays >=7){
        formatKey = DateTimeUtil.formatDateTime(key,format: DateTimeUtil.ymdhn);
      }else{
        formatKey = DateTimeUtil.formatWeekDateTime(key);
      }
      recordMap[formatKey] = value;
    });

    state.recordMap.value = recordMap;
    Log.i("聊天记录Map数据: ${recordMap.keys.toList()}");
  }

  /*
   * @author Marinda
   * @date 2023/6/5 17:12
   * @description 验证TimeExists
   */
  bool validTimeExists(DateTime targetDateTime,Map<DateTime,List<DateTime>> map){
    bool flag = false;
    for(DateTime key in map.keys){
      List<DateTime> list = map[key] ?? [];
      if(list.contains(targetDateTime)){
        flag = true;
        break;
      }
      print('是否存在过这个日期: ${list.contains(targetDateTime)}');
    }
    return flag;
  }
  /*
   * @author Marinda
   * @date 2023/5/29 18:41
   * @description 打开图像 选择图像插入至消息数据库中
   */
  void openImagePicker() async{
    final XFile? image = await state.picker!.pickImage(source: ImageSource.gallery);
    User user = userState.user.value;
    int uid = user.id ?? -1;
    if(image != null){
      String path = image!.path;
      File file = File(path);
      //上传图片至云端
      var uploadPath = await UserAPI.uploadPortrait(file, userState.user.value);
      Message message = Message(content: "",type: MessageType.IMAGE.type,expandAddress: uploadPath,time: DateTime.now());

      APIResult apiResult = await MessageAPI.insertMessage(message);

      int mid = apiResult.data;
      await MessageAPI.insertChatInfo(ChatInfo(sendId: uid,mid:mid,receiverId: state.receiverId.value,type: state.type.value));
      await syncInsertMessage(ChatMessage(uid: uid,mid: mid,receiverType: ReceiverType.CONTACT,receiverId: state.receiverId.value),MessageType.IMAGE,uploadPath);
      ChatMessage chatMessage = ChatMessage(uid: uid,mid: mid,receiverId: state.receiverId.value,receiverType: ReceiverType.getMessageType(state.type.value));
      Packet packet = Packet(type: 2,object: chatMessage);
      Log.i("发包详情：${packet.toJson()}");
      String packetJSON = json.encode(packet);
      Log.i("packetJson: ${packetJSON}");
      state.socketHandle?.write(packetJSON);
      Log.i("图片文件地址：${path}");
    }
  }

  /*
   * @author Marinda
   * @date 2023/6/3 11:35
   * @description 打开视频 模拟器没相机不好测试
   */
  void openVideoPicker() async{
    final XFile? video = await state.picker!.pickVideo(source: ImageSource.camera);
  }

  /*
   * @author Marinda
   * @date 2023/6/17 15:34
   * @description 关闭详情
   */
  back(){
    Get.back(result: state.sendFlag);
  }



  /*
   * @author Marinda
   * @date 2023/6/3 14:07
   * @description 发送消息
   */
  void sendMessage() async{
    MessageType messageType = MessageType.TEXT;
    ReceiverType type = state.type.value == 1 ? ReceiverType.CONTACT : ReceiverType.GROUP;
    String message = state.messageController.text;
    if(message.isEmpty){ return;}
    int uid = userState.user.value.id ?? 0;
    int receiverId = state.receiverId.value;
    Message msg = Message(content: message,type: messageType.type,time: DateTime.now());
    APIResult response = await MessageAPI.insertMessage(msg);
    int mid = response.data;
    Log.i("当前消息id: ${mid}");
    //插入用户信息
    User user = await UserAPI.selectByUid(uid);
    String portrait = user.portrait ?? "";
    Log.i("用户信息: ${user.toJson()}");
    ChatInfo chatInfo = ChatInfo(sendId: uid,receiverId: receiverId,type: type.type,mid: mid);
    ChatRecordData recordData = ChatRecordData(sendId: uid,targetId: mid,message: message,time: DateTime.now(),messageType: messageType,portrait: portrait);
    await MessageAPI.insertChatInfo(chatInfo);
    state.chatRecordList.add(recordData);
    sortRecordInfo();

    ChatMessage chatMessage = ChatMessage(uid: uid,mid: mid,receiverId: receiverId,receiverType: type);
    Packet packet = Packet(type: 2,object: chatMessage);
    Log.i("发包详情：${packet.toJson()}");
    String packetJSON = json.encode(packet);
    Log.i("packetJson: ${packetJSON}");
    state.socketHandle?.write(packetJSON);
    state.messageController.text = "";
    state.sendFlag = true;
  }

  /*
   * @author Marinda
   * @date 2023/6/16 17:22
   * @description 通过异步socket插入Message
   */
   syncInsertMessage(ChatMessage chatMessage,[MessageType? msgType,String? expandAddress]) async{
    int targetId = userState.user.value.id ?? -1;
    Message msg = await MessageAPI.selectMessageById(chatMessage.mid ?? -1);
    String message = msg.content ?? "";
    DateTime dt = DateTime.now();

    int sendId = chatMessage.receiverId!;
    User user = await userLogic.selectByUid(sendId);
    String portrait = user.portrait!;
    MessageType messageType;
    if(msgType != null){
      messageType = msgType;
    }else{
      messageType = MessageType.getMessageType(msg.type ?? -1)!;
    }
    ChatRecordData chatRecordData = ChatRecordData(portrait: portrait,targetId: targetId,message: message,messageType: messageType,time: dt,sendId: sendId,expandAddress: expandAddress);
    state.chatRecordList.add(chatRecordData);
    initChatRecordDataList();
  }

  /*
   * @author Marinda
   * @date 2023/6/3 11:30
   * @description 录音处理
   */
  void chooseSubChild(String type){
    Log.i("当前type: ${type}");
    if(state.subChildType.value == ""){
      state.subChildType.value = type;
      state.chooseSubChild.value = true;
      state.animatedController!.reset();
      state.animatedController!.forward();
      return;
    }
    //如果储存过的类型为空的则直接展示
    //如果是一样的则默认视为取消当前展示状态
    if(type == state.subChildType.value || state.subChildType.value == ""){
      state.chooseSubChild.value = !state.chooseSubChild.value;
      return;
    }
    state.subChildType.value = type;
    state.animatedController!.reset();
    state.animatedController!.forward();
  }


  /*
   * @author Marinda
   * @date 2023/5/26 11:10
   * @description 构建聊天信息
   */
  List<Widget> buildChatMessage(){
    List<Widget> list = [];
    print('记录Map总长度: ${state.recordMap.length}');
    //遍历记录列表
    for(String key in state.recordMap.keys){
      List<ChatRecordData> element = state.recordMap[key] ?? [];
      //这个是需要做一下特殊处理如果距离下一个时间点间隔差 达到5分钟视为新消息
      Widget child = Container(
        child: Column(
          children: [
            //  时间
            Container(
              height: 200.rpx,
              child: Center(
                // child: Text("星期二 晚上 5:53"),
                child: Text("${key}"),
              ),
            ),
            //信息
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.rpx),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: buildChatRecordInfo(element),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
      list.add(child);
    }
    return list;
  }

  /*
   * @author Marinda
   * @date 2023/5/29 10:36
   * @description 构建聊天信息
   */

  List<Widget> buildChatRecordInfo(List<ChatRecordData> chatRecordDataList) {
    List<Widget> list = [];
    for (ChatRecordData chatRecordData in chatRecordDataList) {
      int sendId = chatRecordData.sendId!;
      int uid = userState.user.value.id??0;
      Widget widget = Container(
        margin: EdgeInsets.only(bottom: 100.rpx),
        child: Row(
          //receiverId = 1 自己 2其他
          mainAxisAlignment: sendId == uid
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            ...buildChatRecordItem(chatRecordData)
          ],
        ),
      );
      list.add(widget);
    }
    return list;
  }

  /*
   * @author Marinda
   * @date 2023/5/29 10:30
   * @description 构建聊天项目 type = 1 自己 type = 2其他
   */
  List<Widget> buildChatRecordItem(ChatRecordData chatRecordData){
    List<Widget> list = [];
    int uid = userState.user.value.id ?? -1;
    int sendId = chatRecordData.sendId!;
    Widget expaned = SizedBox(width: 50.rpx);
    Widget message = buildMessageTypeComponent(chatRecordData);
    Widget portait = Container(
      margin: EdgeInsets.only(right: 20.rpx),
      width: 150.rpx,
      height: 150.rpx,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10000),
          image: DecorationImage(
              image: Image
                  .network("${chatRecordData.portrait}")
                  .image,
              fit: BoxFit.fill
          )
      ),
    );
    //自己
    if(sendId == uid){
      list.add(message);
      list.add(expaned);
      list.add(portait);
    }else{
      list.add(portait);
      list.add(expaned);
      list.add(message);
    }
    return list;
  }

  /*
   * @author Marinda
   * @date 2023/6/17 10:34
   * @description 根据消息类型构建不同的消息组件
   */

  Widget buildMessageTypeComponent(ChatRecordData chatRecordData){
    Widget widget = Container();
    MessageType messageType = chatRecordData.messageType!;
    int uid = userState.user.value.id ?? -1;
    String message = chatRecordData.message ?? "";
    int sendId = chatRecordData.sendId!;
    switch(messageType){
      case MessageType.TEXT:
        widget = Container(
          padding: EdgeInsets.all(40.rpx),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: sendId == uid ? Colors.blue : Colors.white
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: 800.rpx,
                minWidth: 200.rpx
            ),
            child: Text(
                "${message}",
                style: TextStyle(color: sendId == uid ? Colors.white : Colors.black,fontSize: 14)
            ),
          ),
        );
        break;
      case MessageType.IMAGE:
        Log.i("图片类型");
        widget = Container(
          padding: EdgeInsets.all(5.rpx),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white,width: 2)
              // color: Colors.white
          ),
          child: SizedBox(
            width: 600.rpx,
            height: 500.rpx,
            child: Image.network(
                chatRecordData.expandAddress ?? "",
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill),
        )
        );
        break;
    }
    return widget;
  }


}
