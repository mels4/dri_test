import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:meli_driweather/app/data/weather_condition.dart';
import 'package:meli_driweather/component/button.dart';
import 'package:meli_driweather/component/custom_view.dart';
import 'package:meli_driweather/component/text_shadow.dart';
import 'package:meli_driweather/theme/color.dart';
import 'package:meli_driweather/theme/size.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return customViewBg(
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 31),
            child: InkWell(
              onTap: () {
                Get.toNamed("search-weather");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 20,
                    children: [
                      SvgPicture.asset("assets/icons/map.svg"),
                      Obx(
                        () => Row(
                          spacing: 10,
                          children: [
                            Text(
                              controller.location.value,
                              style: TextTheme.of(context).titleLarge?.copyWith(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  BoxShadow(
                                    offset: Offset(-2, 3),
                                    blurRadius: 1,
                                    color: blackColor.withValues(alpha: 0.1),
                                  ),
                                ],
                              ),
                            ),
                            Transform.rotate(
                              angle: 1.5,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: white1Color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      controller.notifIcon(context);
                    },
                    child: SvgPicture.asset("assets/icons/notif.svg"),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Obx(
              () =>
                  controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : controller.error.value.isNotEmpty
                      ? Center(child: Text(controller.error.value))
                      : Column(
                        children: [
                          SizedBox(height: 50),
                          Image.asset(
                            "assets/images/sun_cloudy.png",
                            height: 172,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(31, 34, 31, 50),
                            width: double.infinity,
                            height: 305,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: white1Color, width: 2),
                            ),
                            child: ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: whiteColor.withValues(alpha: 0.3),
                                  ),
                                  child: Column(
                                    children: [
                                      CustomPaint(
                                        size: Size(121, 127),
                                        painter: TextShadow(
                                          text:
                                              "${controller.weatherModel.value?.temperature}°",
                                          fontSize: 100,
                                        ),
                                      ),
                                      textShadow1(
                                        controller.weatherModel.value != null
                                            ? getWeatherCondition(
                                              controller
                                                  .weatherModel
                                                  .value!
                                                  .weatherCode!,
                                            )
                                            : "",
                                        fontSize: t1,
                                      ),
                                      SizedBox(height: 24),
                                      Row(
                                        spacing: 20,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              spacing: 5,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/icons/windy.svg",
                                                  width: 24,
                                                  height: 24,
                                                ),
                                                textShadow1(
                                                  "Wind",
                                                  textAlign: TextAlign.end,
                                                ),
                                              ],
                                            ),
                                          ),
                                          textShadow1("|"),

                                          Expanded(
                                            child: textShadow1(
                                              controller.weatherModel.value !=
                                                      null
                                                  ? "${controller.weatherModel.value!.humidity}km/h"
                                                  : "",
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        spacing: 20,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              spacing: 5,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/icons/hum.svg",
                                                  width: 24,
                                                  height: 24,
                                                ),
                                                textShadow1(
                                                  "Hum",
                                                  textAlign: TextAlign.end,
                                                ),
                                              ],
                                            ),
                                          ),
                                          textShadow1("|"),
                                          Expanded(
                                            child: textShadow1(
                                              controller.weatherModel.value !=
                                                      null
                                                  ? "${controller.weatherModel.value!.humidity}%"
                                                  : "",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          CustomButton().buttonGradient(
                            context: context,
                            width: 220,
                            text: "View Details",
                            onTap: () {
                              Get.toNamed(
                                "/detail-weather",
                                arguments: {
                                  "lat": controller.lat.value,
                                  "lon": controller.lot.value,
                                },
                              );
                            },
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: blue5Color,
                            ),
                          ),
                        ],
                      ),
            ),
          ),
        ],
      ),
      // )
      //     ],
      //   ),
      // ),
    );
  }
}
