import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:meli_driweather/app/data/api_service.dart';
import 'package:meli_driweather/app/data/notificcation_model.dart';
import 'package:meli_driweather/app/data/weather_model.dart';
import 'package:meli_driweather/component/text_shadow.dart';
import 'package:meli_driweather/theme/color.dart';
import 'package:meli_driweather/theme/size.dart';

class HomeController extends GetxController {
  final lat = 0.0.obs;
  final lot = 0.0.obs;
  final location = "".obs;
  final weatherModel = Rxn<WeatherModel>();
  final error = "".obs;
  final isLoading = true.obs;

  final dataNew = [
    NotifData(
      icon: "assets/icons/hum.svg",
      time: "10 minutes",
      subtitle:
          "A sunny day in your location, consider wearing your UV protection",
    ),
  ];
  final dataEarlier = [
    NotifData(
      icon: "assets/icons/hum.svg",
      time: "1 day",
      subtitle:
          "A cloudy day will occur all day long, don't worry about the heat of the sun",
    ),
    NotifData(
      icon: "assets/icons/raini.svg",
      time: "2 day",
      subtitle:
          "Potential for rain today is 84%, don't forget to bring your umbrella.",
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    loc();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loc() async {
    final status = await getLocationPermission();
    if (status) {
      getLocation();
    }
  }

  Future<bool> getLocationPermission() async {
    bool en = false;
    LocationPermission permission;

    en = await Geolocator.isLocationServiceEnabled();
    if (!en) {}
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        failedDialog();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      failedDialog();
      return false;
    }
    return true;
  }

  void failedDialog({String? subtitle}) {
    showGeneralDialog(
      context: Get.context!,
      pageBuilder:
          (context, a1, a2) => AlertDialog(
            title: Text("Failed"),
            content: Text(
              subtitle ??
                  "please to setting permission access bcs your location not permit",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Back"),
              ),
            ],
          ),
    );
  }

  void getLocation() async {
    await Geolocator.getCurrentPosition()
        .then((position) async {
          lat.value = position.latitude;
          lot.value = position.longitude;
          await getAddressLocation(position);
          getWeather();
        })
        .catchError((e) {});
  }

  Future getAddressLocation(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((placemark) {
          final place = placemark[0];
          location.value = place.name ?? "";
        })
        .catchError((e) {});
  }

  void getWeather() async {
    isLoading.value = true;
    final res = await Apiservices().getRealtimeWeather(lat.value, lot.value);
    if (res.status.code == 200) {
      weatherModel.value = WeatherModel.fromJson(res.body);
      isLoading.value = false;
    } else {
      isLoading.value = false;
      error.value = res.body.toString();
    }
  }

  void notifIcon(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      showDragHandle: true,
      builder:
          (context) => Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(),
                ),
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: white1Color,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            child: textShadow1(
                              "Your notification",
                              color: blue5Color,
                              textAlign: TextAlign.left,
                              fontWeight: FontWeight.bold,
                              fontSize: t1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 5,
                            ),
                            child: Text(
                              "New",
                              style: TextStyle(fontSize: c2, color: blue5Color),
                            ),
                          ),

                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: dataNew.length,
                            itemBuilder: (c, i) {
                              final item = dataNew[i];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 10,
                                ),
                                color: blue6Color.withValues(alpha: 0.28),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    SvgPicture.asset(
                                      item.icon,
                                      color: blue5Color,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.time,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              color: blue5Color,
                                            ),
                                          ),
                                          Text(
                                            item.subtitle,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: blue5Color,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Transform.rotate(
                                      angle: 1.5,
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 5,
                            ),
                            child: Text(
                              "Earlier",
                              style: TextStyle(fontSize: c2, color: blue5Color),
                            ),
                          ),

                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: dataEarlier.length,
                            itemBuilder: (c, i) {
                              final item = dataEarlier[i];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 10,
                                ),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    SvgPicture.asset(
                                      item.icon,
                                      color: Color(0xff838BAA),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.time,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              color: Color(0xff838BAA),
                                            ),
                                          ),
                                          Text(
                                            item.subtitle,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff838BAA),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Transform.rotate(
                                      angle: 1.5,
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 20,
                                        color: Color(0xff838BAA),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
