import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meli_driweather/component/custom_view.dart';
import 'package:meli_driweather/component/text_shadow.dart';
import 'package:meli_driweather/theme/color.dart';
import 'package:meli_driweather/theme/size.dart';

import '../controllers/detail_weather_controller.dart';

class DetailWeatherView extends GetView<DetailWeatherController> {
  const DetailWeatherView({super.key});
  @override
  Widget build(BuildContext context) {
    return customViewBg(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_rounded,
                        color: whiteColor,
                        size: 20,
                      ),
                      textShadow1("Back"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textShadow1("Today", fontWeight: FontWeight.bold, fontSize: t1),
                textShadow1(DateFormat('E, d').format(DateTime.now())),
              ],
            ),
          ),
          controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                height: 150,
                padding: EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  itemCount:
                      controller.todayWeather.value != null
                          ? controller.todayWeather.value?.length
                          : 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (c, i) {
                    final item = controller.todayWeather.value![i];
                    return Container(
                      margin: EdgeInsets.fromLTRB(i == 0 ? 30 : 0, 3, 3, 0),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textShadow1("${item.temperature}°"),
                          SvgPicture.asset(
                            "assets/images/sun.svg",
                            width: 24,
                            height: 24,
                          ),
                          textShadow1(DateFormat("HH.mm").format(item.time)),
                        ],
                      ),
                    );
                  },
                ),
              ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: textShadow1(
              "Next Forecast",
              fontSize: t1,
              fontWeight: FontWeight.bold,
            ),
          ),
          controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                height: 350,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: ListView.builder(
                  itemCount:
                      controller.weekWeather.value != null
                          ? controller.weekWeather.value?.length
                          : 0,
                  itemBuilder: (c, i) {
                    final item = controller.weekWeather.value![i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textShadow1(
                            DateFormat('E, d').format(item.time),
                            fontWeight: FontWeight.bold,
                          ),
                          SvgPicture.asset(
                            "assets/images/sun.svg",
                            width: 24,
                            height: 24,
                          ),
                          textShadow1("${item.temperature}°"),
                        ],
                      ),
                    );
                  },
                ),
              ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textShadow1("DRI Weather", textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
