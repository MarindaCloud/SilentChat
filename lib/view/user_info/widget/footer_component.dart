import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silentchat/view/user_info/logic.dart';
import 'package:silentchat/view/user_info/state.dart';
/**
 * @author Marinda
 * @date 2023/6/21 15:51
 * @description 底部组件
 */
class FooterComponent extends StatefulWidget{

  final UserInfoLogic logic;
  final UserInfoState state;

  FooterComponent(this.logic,this.state);
  @override
  State<StatefulWidget> createState() {
    return FooterComponentState();
  }

}

class FooterComponentState extends State<FooterComponent>{

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 50,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //编辑资料
          Expanded(
            child: TextButton(
              onPressed: ()=>widget.logic.toEditUserInfo(),
              child: Container(
                child: Center(
                  child: Text("修改资料",style: TextStyle(color: Colors.grey,fontSize: 18),overflow: TextOverflow.ellipsis,),
                ),
              ),
            ),
          ),
          //编辑资料

        ],
      ),
    );
  }

}