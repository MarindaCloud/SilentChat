import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/socket/socket_handle.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:image_picker/image_picker.dart';
import 'state.dart';

class ChatLogic extends GetxController with GetSingleTickerProviderStateMixin{
  final ChatState state = ChatState();

  @override
  void onInit() {
    state.socketHandle = Get.find<SocketHandle>();
    final ImagePicker picker = ImagePicker();
    state.picker = picker;
    state.animatedController = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    state.fadeValue = Tween<double>(begin: 0,end: 1).animate(state.animatedController!);
  }

  /*
   * @author Marinda
   * @date 2023/5/29 18:41
   * @description 打开图像
   */
  void openImagePicker() async{
    final XFile? image = await state.picker!.pickImage(source: ImageSource.gallery);
  }

  void sendMessage(){
    state.socketHandle?.write("这是一条消息");
    // SocketHandle().write(data)
  }

  /*
   * @author Marinda
   * @date 2023/6/3 11:30
   * @description 录音处理
   */
  void recording(){
    state.animatedController!.reset();
    state.animatedController!.forward();
    state.chooseRecording.value = !state.chooseRecording.value;
  }

  /*
   * @author Marinda
   * @date 2023/5/26 11:10
   * @description 构建聊天信息
   */
  List<Widget> buildChatMessage(){
    List<Widget> list = [];
    for(int i = 0;i<10;i++){
      Widget child = Container(
        child: Column(
          children: [
          //  时间
            Container(
              height: 200.rpx,
              child: Center(
                child: Text("星期二 晚上 5:53"),
              ),
            ),
            //信息
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.rpx),
              child: Column(
                children: [
                  Visibility(
                    visible: i > 5,
                      child: Column(
                        children: [...buildChatInfo(3, 2)],
                      ),
                  ),
                  Visibility(
                    visible: i < 5,
                    child: Column(
                      children: [...buildChatInfo(5, 1)],
                    ),
                  )
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

  List<Widget> buildChatInfo(int num,int type){
    List<Widget> list = [];
    for(int i = 0;i<num;i++){
      Widget widget = Container(
        margin: EdgeInsets.only(bottom: 100.rpx),
        child: Row(
          mainAxisAlignment: type == 2 ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            ...buildChatItem(type)
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
  List<Widget> buildChatItem(int type){
    List<Widget> list = [];

    Widget expaned = SizedBox(width: 50.rpx);
    Widget message = Container(
      padding: EdgeInsets.all(40.rpx),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: type == 1 ? Colors.blue : Colors.white
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: 500.rpx,
            minWidth: 100.rpx
        ),
        child: Text(
            "这是一条新消息",
            style: TextStyle(color: type == 1 ? Colors.white : Colors.black,fontSize: 14)
        ),
      ),
    );
    Widget portait = Container(
      margin: EdgeInsets.only(right: 20.rpx),
      width: 150.rpx,
      height: 150.rpx,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10000),
          image: DecorationImage(
              image: Image
                  .asset("assets/user/portait.png")
                  .image,
              fit: BoxFit.fill
          )
      ),
    );
    //自己
    if(type == 1){
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

}
