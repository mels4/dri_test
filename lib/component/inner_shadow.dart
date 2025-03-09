import 'package:flutter/material.dart';

class CustomInnerShadow extends CustomPainter {
  final Color firstColor;
  final Color secondColor;
  CustomInnerShadow({
    this.firstColor = Colors.black,
    this.secondColor = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint shadow1 =
        Paint()
          ..color = firstColor.withValues(alpha: 0.25)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6);
    Paint shadow2 =
        Paint()
          ..color = secondColor.withValues(alpha: 0.9)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);

    Rect r = Rect.fromLTWH(0, 0, size.width, size.height);
    RRect round = RRect.fromRectAndRadius(r, Radius.circular(20));

    canvas.save();
    canvas.translate(-3, 2);
    canvas.drawRRect(round, shadow1);
    canvas.restore();

    canvas.save();
    canvas.translate(4, -6);
    canvas.drawRRect(round, shadow2);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
