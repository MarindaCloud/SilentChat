import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'state.dart';

/**
 * @author Marinda
 * @date 2023/5/25 16:10
 * @description  联系人逻辑
 */
class ContactLogic extends GetxController {
  final ContactState state = ContactState();

  /*
   * @author Marinda
   * @date 2023/5/25 16:58
   * @description 构建朋友控件列表
   */
  List<Widget> buildFriends(){
    List<Widget> list = [];
    for(int i = 0;i<state.letterList.length;i++){
      Widget child = Container(
        margin: EdgeInsets.only(bottom: 50.rpx),
        child: Column(
          children: [
            //拼音分组
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 30.rpx),
              child: Text(
                  state.letterList[i],
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14
                ),
              ),
            ),
            //用户列表
            Container(
              child: Column(
                children: [
                  //用户信息
                  Container(
                    child: Row(
                      children: [
                        //头像
                        Container(
                          width: 150.rpx,
                          height: 150.rpx,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10000),
                              image: DecorationImage(
                                  image: Image
                                      .asset("assets/logo.jpg")
                                      .image,
                                  fit: BoxFit.fill
                              )
                          ),
                        ),
                        //  昵称 & 设备&个签
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 30.rpx),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                      child: Text("云", style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                        overflow: TextOverflow.ellipsis,)
                                  ),
                                ),
                                //状态 & 登录设备
                                Container(
                                  margin: EdgeInsets.only(top: 5.rpx),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Text("[IPhoneXR]在线个性签名",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14),),
                                      )
                                    ],
                                  ),
                                )
                              ],
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
