import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/common/components/icon_button.dart';
import 'package:silentchat/util/font_rpx.dart';

import 'logic.dart';

class EditFriendsInfoPage extends StatelessWidget {
  EditFriendsInfoPage({Key? key}) : super(key: key);

  final logic = Get.find<EditFriendsInfoLogic>();
  final state = Get.find<EditFriendsInfoLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(247, 247, 247, 1),
        child: SafeArea(
          child: Column(
            children: [
              //头部
              Container(
                width: Get.width,
                margin: EdgeInsets.only(bottom: 50.rpx),
                padding: EdgeInsets.only(top: 50.rpx,bottom: 50.rpx),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Transform.translate(
                        offset: Offset(130.rpx,0),
                        child: IconButtonComponent.build("back", color: Colors.black,onClick: logic.toBack,)
                    ),
                    Container(
                      child: Text("好友管理",style: TextStyle(fontSize: 16)),
                    ),
                    SizedBox()
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                    color: Color.fromRGBO(241, 241, 241, 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //修改备注
                        Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(bottom: 50.rpx),
                          padding: EdgeInsets.only(left: 100.rpx,right: 100.rpx),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: InkWell(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 50.rpx,top: 50.rpx),
                                    decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(color:  Color.fromRGBO(234, 234, 234, 1))
                                      )
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(right: 50.rpx),
                                            child: Icon(Icons.account_box,color: Colors.black,)
                                        ),
                                        Container(
                                          child: Text(
                                              "更改备注",
                                              style: TextStyle(color: Colors.black,fontSize: 16)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: (){
                                    logic.showUpdateNote();
                                    print("更改备注");
                                  },
                                ),
                              ),
                              SizedBox()
                            ],
                          ),
                        ),

                        //删除好友
                        Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(bottom: 50.rpx),
                          padding: EdgeInsets.only(left: 100.rpx,right: 100.rpx),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: InkWell(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 50.rpx,top: 50.rpx),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(color:  Color.fromRGBO(234, 234, 234, 1))
                                        )
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(right: 50.rpx),
                                            child: Icon(Icons.delete,color: Colors.black,)
                                        ),
                                        Container(
                                          child: Text(
                                              "删除好友",
                                              style: TextStyle(color: Colors.black,fontSize: 16)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: (){
                                    print("删除好友");
                                    logic.removeFriend();
                                  },
                                ),
                              ),
                              SizedBox()
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
