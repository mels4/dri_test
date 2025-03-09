import 'package:get/get.dart';

import '../modules/detail_weather/bindings/detail_weather_binding.dart';
import '../modules/detail_weather/views/detail_weather_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onboard/bindings/onboard_binding.dart';
import '../modules/onboard/views/onboard_view.dart';
import '../modules/search_weather/bindings/search_weather_binding.dart';
import '../modules/search_weather/views/search_weather_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARD;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARD,
      page: () => const OnboardView(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_WEATHER,
      page: () => const DetailWeatherView(),
      binding: DetailWeatherBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_WEATHER,
      page: () => const SearchWeatherView(),
      binding: SearchWeatherBinding(),
    ),
  ];
}
