import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'state.dart';

class MessageLogic extends GetxController {
  final MessageState state = MessageState();
  
  /*
   * @author Marinda
   * @date 2023/5/25 15:24
   * @description 构建工具列表
   */
  List<Widget> buildToolsList(){
    List<Widget> list = [];
    //创建群聊 添加好友 扫一扫
    for(int i = 0;i<3;i++){
      Widget child = InkWell(
        child: Container(
          height: 100.rpx,
          margin: EdgeInsets.only(bottom: i == 2? 0 :  100.rpx),
          child: Row(
            children: [
              //图标
              Container(
                margin: EdgeInsets.only(right: 30.rpx),
                width: 100.rpx,
                height: 100.rpx,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset("assets/logo.jpg").image,
                    fit: BoxFit.fill
                  )
                ),
              ),
            //  文字
              Expanded(child: Text(
                getToolName(i),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
              ))
            ],
          ),
        ),
        onTap: (){
          print(getToolName(i));
        },
      );
      list.add(child);
    }
    return list;
  }

  /*
   * @author Marinda
   * @date 2023/5/25 15:51
   * @description 构建聊天记录
   */
  List<Widget> buildRecordList(){
    List<Widget> list = [];
    for(int i = 0;i<15;i++){
      Widget child = InkWell(
        child: Container(
          padding: EdgeInsets.only(right: 40.rpx, top: 10.rpx,left: 40.rpx),
          margin: EdgeInsets.only(bottom: 80.rpx),
          child: Row(
            children: [
              //头像
              Container(
                margin: EdgeInsets.only(right: 20.rpx),
                width: 200.rpx,
                height: 200.rpx,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10000),
                  image: DecorationImage(
                    image: Image.asset("assets/logo.jpg").image,
                    fit: BoxFit.fill
                  )
                ),
              ),
              //名称 & 最新消息
              Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        //名称
                        Container(
                          child: Row(
                            children: [
                            //  名称
                              Text(
                                  "U.E.Studio - A.F.今天写完",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              //时间
                              Container(
                                child: Text("下午 3:33",style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),),
                              )
                            ],
                          ),
                        ),
                        //最新消息
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "这是一条最新消息",
                            style: TextStyle(
                              color: Colors.grey,
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
        onTap: (){
          print("i: ${i}");
        },
      );
      list.add(child);
    }
    return list;
  }


  /*
   * @author Marinda
   * @date 2023/5/25 15:30
   * @description 获取工具名称
   */
  String getToolName(int index){
    String result = "";
    switch(index){
      case 0:
        result = "创建群聊";
        break;
      case 1:
        result = "加好友/群";
        break;
      case 2:
        result = "扫一扫";
        break;
    }
    return result;
  }
}
