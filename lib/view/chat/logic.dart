import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'state.dart';

class ChatLogic extends GetxController {
  final ChatState state = ChatState();


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
                  i < 5 ? Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20.rpx),
                          padding: EdgeInsets.all(40.rpx),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: i > 5  ? Colors.white :Colors.blue
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: 500.rpx,
                                minWidth: 100.rpx
                            ),
                            child: Text(
                                "这是一条新消息",
                                style: TextStyle(color: i > 5 ? Colors.black:Colors.white,fontSize: 14)
                            ),
                          ),
                        ),
                        //头像
                        Container(
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
                        ),
                      ],
                    ),
                  ) : Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //头像
                        Container(
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
                        ),
                        Container(
                          padding: EdgeInsets.all(40.rpx),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: i > 5  ? Colors.white :Colors.blue
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: 500.rpx,
                                minWidth: 100.rpx
                            ),
                            child: Text(
                                "这是一条新消息",
                                style: TextStyle(color: i > 5 ? Colors.black:Colors.white,fontSize: 14)
                            ),
                          ),
                        ),
                      ],
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
}
