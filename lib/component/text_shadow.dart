import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meli_driweather/theme/color.dart';
import 'package:meli_driweather/theme/size.dart';

class TextShadow extends CustomPainter {
  final String text;
  final Color firstColor;
  final Color secondColor;
  final double fontSize;
  final FontWeight? fontWeight;

  TextShadow({
    required this.text,
    this.fontWeight,
    this.firstColor = Colors.white,
    this.secondColor = white3Color,
    this.fontSize = 18,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textPaint = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: GoogleFonts.overpass(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: whiteColor,
        ),
      ),
    );
    textPaint.layout();
    Offset textOffset = Offset((size.width - textPaint.width) / 2, 10);

    final strokePaint = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text,
        style: GoogleFonts.overpass(
          fontSize: fontSize,
          fontWeight: fontWeight,

          foreground:
              Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..shader = RadialGradient(
                  colors: [firstColor, secondColor],
                ).createShader(
                  Rect.fromLTWH(0, 0, size.width / 2, size.height / 2),
                ),
        ),
      ),
    );

    strokePaint.layout();
    strokePaint.paint(canvas, textOffset);

    textPaint.paint(canvas, textOffset);

    Paint inShadow1 =
        Paint()
          ..color = Colors.black.withValues(alpha: 0.3)
          // ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6)
          ..blendMode = BlendMode.dstOut;

    Paint inShadow2 =
        Paint()
          ..color = Colors.white.withValues(alpha: 0.25)
          // ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4)
          ..blendMode = BlendMode.dstOut;

    canvas.saveLayer(textOffset & textPaint.size, inShadow1);
    textPaint.paint(canvas, textOffset.translate(2, -3));
    canvas.restore();

    canvas.saveLayer(textOffset & textPaint.size, inShadow2);
    textPaint.paint(canvas, textOffset.translate(-6, 4));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

Widget textShadow1(
  String text, {
  double? fontSize,
  TextAlign? textAlign,
  FontWeight? fontWeight,
  Color? color,
}) => Text(
  text,
  textAlign: textAlign,
  style: GoogleFonts.overpass(
    color: color ?? whiteColor,
    fontSize: fontSize ?? t2,
    fontWeight: fontWeight,
    shadows: [
      Shadow(
        offset: Offset(-2, 3),
        blurRadius: 1,
        color: blackColor.withValues(alpha: 0.1),
      ),
    ],
  ),
);
