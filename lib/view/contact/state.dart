import 'package:get/get.dart';
class ContactState {
  final showAddFriends = false.obs;
  final page = 0.obs;
  List<String> letterList = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
  final chooseLetter = "A".obs;
  ContactState() {
    ///Initialize variables
  }
}
