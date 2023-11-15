import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'state.dart';

class AppendAnnouncementLogic extends GetxController {
  final AppendAnnouncementState state = AppendAnnouncementState();

  @override
  void onInit() {
    init();
    // TODO: implement onInit
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/10/10 10:54
   * @description 初始化公告信息
   */
  init(){
    var group = Get.arguments;
    state.group = group;
  }

  /*
   * @author Marinda
   * @date 2023/10/10 10:58
   * @description 提交
   */
  submit(){
    String content = state.contentController.text;
  }

  pickImage() async{
    XFile? imgElement = await state.imagePicker.pickImage(source: ImageSource.gallery);
    print('图像地址: ${imgElement!.path}');
    state.imgPath.value = imgElement.path;
  }
}
