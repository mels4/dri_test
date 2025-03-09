import 'package:get/get.dart';

import '../controllers/search_weather_controller.dart';

class SearchWeatherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchWeatherController>(
      () => SearchWeatherController(),
    );
  }
}
