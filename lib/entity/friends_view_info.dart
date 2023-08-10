

/**
 * @author Marinda
 * @date 2023/7/6 13:50
 * @description 朋友信息视图
 */
class FriendsViewInfo {
  dynamic element;
  String? letter;

  FriendsViewInfo({this.element,this.letter});

  get getElement => element;
  get getLetter => letter;


  set setElement(dynamic element) => this.element = element;
  set setLetter(String? letter) => this.letter = letter;
}