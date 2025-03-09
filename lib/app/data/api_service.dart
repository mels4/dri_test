import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class Apiservices extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = dotenv.get('BASE_URL');
  }

  final url = dotenv.get('BASE_URL');
  final key = dotenv.get("API_KEY");

  Future<Response> getRealtimeWeather(double lat, double lon) async {
    return await get(
      "$url/realtime",
      query: {"location": "$lat,$lon", "apikey": key},
      // headers: {"x-access-token": token}
    );
  }

  Future<Response> getForecastWeather({
    double? lat,
    double? lon,
    String? timesteps,
  }) async {
    return await get(
      "$url/forecast",
      query: {"location": "$lat,$lon", "timesteps": timesteps, "apikey": key},
      // headers: {"x-access-token": token}
    );
  }
}
