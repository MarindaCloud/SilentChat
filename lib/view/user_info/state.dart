import 'package:silentchat/entity/user.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class UserInfoState {
  final user = User().obs;
  ImagePicker imagePicker = ImagePicker();
  final portrait = "".obs;
  UserInfoState() {
    ///Initialize variables
  }
}
