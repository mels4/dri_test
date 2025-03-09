import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:meli_driweather/component/inner_shadow.dart';
import 'package:meli_driweather/theme/color.dart';

import '../controllers/search_weather_controller.dart';

class SearchWeatherView extends GetView<SearchWeatherController> {
  const SearchWeatherView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // widget(child: TextFormField(decoration: InputDecoration(hintText: "search"))),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      size: Size((MediaQuery.of(context).size.width) - 10, 50),
                      painter: CustomInnerShadow(),
                    ),
                  ),
                  Positioned(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "search",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
