/**
 * @author Marinda
 * @date 2023/10/7 14:06
 * @description 图片地址拓展
 */
extension ImagePathExtension on String{
  String get icon{
    return "assets/icon/$this";
  }
}