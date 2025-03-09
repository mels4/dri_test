import 'package:flutter/material.dart';
import 'package:meli_driweather/component/inner_shadow.dart';
import 'package:meli_driweather/theme/color.dart';

class CustomButton {
  Widget buttonGradient({
    required BuildContext context,
    Function()? onTap,
    double? width,
    Widget? child,
    required String text,
  }) => InkWell(
    onTap: onTap,
    child: Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: white1Color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(-4, 8),
            blurRadius: 50,
            spreadRadius: 0.04,
            color: blackColor.withValues(alpha: 0.1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: CustomPaint(
              size: Size((width ?? MediaQuery.of(context).size.width) - 10, 50),
              painter: CustomInnerShadow(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Text(text, style: TextTheme.of(context).titleSmall),
                if (child != null) child,
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
