class WeatherData {
  double tempFelt;
  double temp;
  double precipitation;
  int isDayTime;
  double latitude;
  double longitude;

  WeatherData(
      {required this.tempFelt,
      required this.temp,
      required this.precipitation,
      required this.isDayTime,
      required this.latitude,
      required this.longitude});

  factory WeatherData.fromJson(Map<String, dynamic> jsonMap) {
    return WeatherData(
      tempFelt: jsonMap["current_units"]["temperature_2m"],
      temp: jsonMap["current_units"]["apparent_temperature"],
      precipitation: jsonMap["current_units"]["precipitation"],
      isDayTime: jsonMap["current_units"]["is_day"],
      latitude: jsonMap["latitude"],
      longitude: jsonMap["longitude"],
    );
  }
}
