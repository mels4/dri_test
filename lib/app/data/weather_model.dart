class WeatherModel {
  final DateTime time;
  final dynamic temperature;
  final dynamic humidity;
  final int? weatherCode;
  final dynamic windSpeed;
  final String? locationName;

  WeatherModel({
    required this.time,
    required this.temperature,
    required this.humidity,
    required this.weatherCode,
    required this.windSpeed,
    this.locationName,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      time: DateTime.parse(json["data"]['time']),
      temperature: json["data"]["values"]["temperature"],
      humidity: json["data"]["values"]["humidity"],
      weatherCode: json["data"]["values"]["weatherCode"],
      windSpeed: json["data"]["values"]["windSpeed"],
      locationName: json["location"]["name"],
    );
  }
  factory WeatherModel.fromJsonForecast(Map<String, dynamic> json) {
    return WeatherModel(
      time: DateTime.parse(json['time']),
      temperature: json["values"]["temperature"],
      humidity: json["values"]["humidity"],
      weatherCode: json["values"]["weatherCode"],
      windSpeed: json["values"]["windSpeed"],
    );
  }
  factory WeatherModel.fromJsonForecastDaily(Map<String, dynamic> json) {
    return WeatherModel(
      time: DateTime.parse(json['time']),
      temperature: json["values"]["temperatureAvg"],
      humidity: json["values"]["humidity"],
      weatherCode: json["values"]["weatherCode"],
      windSpeed: json["values"]["windSpeed"],
    );
  }
}
