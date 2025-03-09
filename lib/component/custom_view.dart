import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meli_driweather/theme/color.dart';

Widget customViewBg(Widget child) => Scaffold(
  backgroundColor: Colors.transparent,
  body: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [blue3Color, blue2Color],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
    ),
    child: Stack(
      children: [
        Positioned(top: 80, child: SvgPicture.asset("assets/images/line.svg")),
        Positioned(
          top: 0,
          left: 100,
          child: SvgPicture.asset("assets/images/line-1.svg"),
        ),
        Positioned(top: 50, left: 0, right: 0, child: child),
      ],
    ),
  ),
);
