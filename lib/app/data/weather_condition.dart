String getWeatherCondition(int code) {
  Map<int, String> weatherConditions = {
    1000: "Sunny",
    1001: "Cloudy",
    1100: "Mostly Clear",
    1101: "Partly Cloudy",
    1102: "Mostly Cloudy",
    2000: "Fog",
    4000: "Drizzle",
    4001: "Rain",
    4200: "Light Rain",
    4201: "Heavy Rain",
    5000: "Snow",
    5100: "Light Snow",
    5101: "Heavy Snow",
  };

  return weatherConditions[code] ?? "Unknown";
}
