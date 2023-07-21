import 'package:flutter/material.dart';
/**
 * @author Marinda
 * @date 2023/7/21 14:17
 * @description 自定义图像的paint
 */
class CustomCanvasPaint extends CustomPainter{
  Offset? offset;
  Size? rectSize;
  bool? drawFlag = false;
  String? direction = "";
  CustomCanvasPaint([this.offset,this.rectSize,this.drawFlag,this.direction]);


  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white..strokeWidth = 2..style = PaintingStyle.stroke;
    print('画布大小：${size}');
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    bool flag = drawFlag ?? false;
    if(flag) {
      //视为移动
      if(direction == "Inside"){
        Rect targetCustomRect = Rect.fromLTWH(
            offset?.dx ?? 0, offset?.dy ?? 0, rectSize?.width ?? size.width, rectSize?.height ?? 230);
        canvas.drawRect(targetCustomRect, paint);
      }else{
        Rect targetCustomRect = Rect.fromLTWH(
            offset?.dx ?? 0, offset?.dy ?? 0, rectSize?.width ?? size.width, rectSize?.height ?? 230);
        canvas.drawRect(targetCustomRect, paint);

      }

    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}