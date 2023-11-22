import 'package:get/get.dart';
import 'package:silentchat/controller/user/logic.dart';
import 'package:silentchat/controller/user/state.dart';
import 'package:image_picker/image_picker.dart';
import 'state.dart';
/**
 * @author Marinda
 * @date 2023/11/21 15:29
 * @description 发布空间动态
 */
class ReleaseSpaceDynamicLogic extends GetxController {
  final ReleaseSpaceDynamicState state = ReleaseSpaceDynamicState();
  final UserLogic userLogic = Get.find<UserLogic>();
  final UserState userState = Get.find<UserLogic>().state;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  pickImage() async{
    XFile? imgElement = await state.imagePicker.pickImage(source: ImageSource.gallery);
    print('图像地址: ${imgElement!.path}');
    state.imgPath.value = imgElement.path;
  }


  clearImage(){
    state.imgPath.value = "";
  }


  /*
   * @author Marinda
   * @date 2023/11/22 10:32
   * @description 清空内容
   */
  resetContent(){
    state.imgPath.value = "";
    state.contentController.text = "";
  }

  /*
   * @author Marinda
   * @date 2023/11/22 10:33
   * @description 发布动态
   */
  submit(){
    String content = state.contentController.text;
    String imgPath = state.imgPath.value;

    
  }
}
