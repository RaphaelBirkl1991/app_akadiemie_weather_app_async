import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app_asynchronous/weather_data.dart';

class WeatherRepository {
  final apiUri =
      'https://api.open-meteo.com/v1/forecast?latitude=48.783333&longitude=9.183333&current=temperature_2m,apparent_temperature,is_day,precipitation&timezone=Europe%2FBerlin&forecast_days=1';

  //  Future<String> jsonString = getDataFromApi();

  Future<String> getDataFromApi() async {
    final Response response = await get(Uri.parse(apiUri));
    final String jsonString = response.body;
    return jsonString;
  }

  // Dekodiert den json string und gibt ein WeatherDatea zurück
  Future<WeatherData> getWeatherData() async {
    final String jsonString = await getDataFromApi();
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final WeatherData newWeatherData = WeatherData.fromJson(jsonMap);
    return newWeatherData;
  }
}
