import 'package:get/get.dart';
import 'package:meli_driweather/app/data/api_service.dart';
import 'package:meli_driweather/app/data/weather_model.dart';

class DetailWeatherController extends GetxController {
  final todayWeather = Rxn<List<WeatherModel>>();
  final weekWeather = Rxn<List<WeatherModel>>();
  final lat = 0.0.obs;
  final lon = 0.0.obs;
  final isLoading = true.obs;
  final error = "".obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments; // Mendapatkan data yang dikirim
    final l = args["lat"];
    final lo = args["lon"];
    lat.value = l ?? 0;
    lon.value = lo ?? 0;

    getForecastToday();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getForecastToday() async {
    isLoading.value = true;
    final res = await Apiservices().getForecastWeather(
      lat: lat.value,
      lon: lon.value,
      timesteps: "1h",
    );
    if (res.status.code == 200) {
      List<dynamic> data = res.body["timelines"]["hourly"];
      todayWeather.value =
          data.map((i) => WeatherModel.fromJsonForecast(i)).toList();
      final resDay = await Apiservices().getForecastWeather(
        lat: lat.value,
        lon: lon.value,
        timesteps: "1d",
      );
      if (resDay.status.code == 200) {
        List<dynamic> datas = resDay.body["timelines"]["daily"];
        weekWeather.value =
            datas.map((i) => WeatherModel.fromJsonForecastDaily(i)).toList();
        isLoading.value = false;
      } else {
        isLoading.value = false;
        error.value = res.body.toString();
      }
    } else {
      isLoading.value = false;
      error.value = res.body.toString();
    }
  }
}
