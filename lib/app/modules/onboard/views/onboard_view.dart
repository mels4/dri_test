import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meli_driweather/component/button.dart';
import 'package:meli_driweather/theme/color.dart';

import '../controllers/onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue3Color,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [blue2Color, whiteColor],
              stops: [-0.46, 1],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -200,
                left: -50,
                child: SvgPicture.asset(
                  "assets/images/cicle.svg",
                  width: 789,
                  height: 789,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3.5,
                left: 47,
                child: SvgPicture.asset(
                  "assets/images/cloud.svg",
                  width: 604,
                  height: 375,
                ),
              ),
              Positioned(
                top: 60,
                left: -90,
                child: Image.asset(
                  "assets/images/sun.png",
                  width: 177,
                  height: 187,
                ),
              ),
              Positioned(
                bottom: 130,
                left: 42,
                right: 52,
                child: Column(
                  spacing: 9,
                  children: [
                    Text(
                      "Never get caught in the rain again",
                      style: TextTheme.of(context).headlineLarge,
                    ),
                    Text(
                      "Stay ahead of the weather with our accurate forecasts",
                    ),
                    SizedBox(height: 8),
                    CustomButton().buttonGradient(
                      context: context,
                      text: "Get Started",
                      onTap: () {
                        controller.startBtn();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
