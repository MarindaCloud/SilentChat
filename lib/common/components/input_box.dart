import 'package:flutter/material.dart';
import 'package:silentchat/util/font_rpx.dart';
import 'package:silentchat/util/overlay_manager.dart';

/**
 * @author Marinda
 * @date 2023/9/15 10:39
 * @description  输入框组件
 */
class InputBoxComponent extends StatelessWidget{
  final String title;
  final Function onFn;
  TextEditingController controller = TextEditingController(text: "");
  InputBoxComponent(this.title,this.onFn,{super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          width: 500.rpx,
          height: 800.rpx,
          color: Color.fromRGBO(247, 247, 247, 1).withOpacity(.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //标题
              Container(
                padding: EdgeInsets.only(top: 50.rpx,bottom: 50.rpx),
                child: Center(
                    child: Text(title,
                        style: TextStyle(color: Colors.black,fontSize: 16)
                    )),
              ),
              //输入框
              Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //输入框
                        Container(
                          margin: EdgeInsets.only(bottom: 30.rpx,left: 50.rpx,right: 50.rpx),
                          child: SizedBox(
                            height: 150.rpx,
                            child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 50.rpx,right: 50.rpx),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey,width: 1),
                                  borderRadius: BorderRadius.circular(15.rpx)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey,width: 1),
                                    borderRadius: BorderRadius.circular(15.rpx)
                                )
                              ),
                            ),
                          )
                        ),
                        Expanded(child: SizedBox()),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //提交
                              InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(right: 100.rpx),
                                  width: 500.rpx,
                                  height: 120.rpx,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5.rpx)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "提交",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  onFn(controller);
                                },
                              ),
                              //退出
                              InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(right: 50.rpx),
                                  width: 500.rpx,
                                  height: 120.rpx,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5.rpx)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "退出",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: (){
                                  OverlayManager().removeOverlay("inputBox");
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
    );
  }

}