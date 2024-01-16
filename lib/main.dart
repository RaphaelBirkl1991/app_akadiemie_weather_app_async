import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app_asynchronous/user_location.dart';

void main() {
  runApp(const MainApp());
}

// const String jsonString = """
//  {
//      "latitude": 48.78,
//      "longitude": 9.18,
//      "current": {
//          "time": "2024-01-12T11:45",
//          "temperature_2m": -3.6,
//          "apparent_temperature": -7.0,
//          "is_day": 1,
//          "precipitation": 12.00
//      }
//  }
//  """;

Future<String> jsonString = getDataFromApi();

const String apiUri =
    'https://api.open-meteo.com/v1/forecast?latitude=48.783333&longitude=9.183333&current=temperature_2m,apparent_temperature,is_day,precipitation&timezone=Europe%2FBerlin&forecast_days=1';

Future<String> getDataFromApi() async {
  final Response response = await get(Uri.parse(apiUri));
  final String jsonString = response.body;
  return jsonString;
}

Future<UserLocation> getUserLocation() async {
  final Map<String, dynamic> jsonMap = jsonDecode(await jsonString);
  double longitude = jsonMap["longitude"];
  double latitude = jsonMap["latitude"];
  final jsonLocation = UserLocation(latitude, longitude);
  return jsonLocation;
}

Future<bool> isDayTime() async {
  bool isDayTime;
  int returnValue;
  final Map<String, dynamic> jsonMap = jsonDecode(await jsonString);
  final Map<String, dynamic> currentData = jsonMap["current"];
  returnValue = currentData["is_day"];
  returnValue == 1 ? isDayTime = true : isDayTime = false;
  return isDayTime;
}

Future<double> getApparentTemp() async {
  double apparentTemp;
  final Map<String, dynamic> jsonMap = jsonDecode(await jsonString);
  final Map<String, dynamic> currentData = jsonMap["current"];
  apparentTemp = currentData["apparent_temperature"];
  return apparentTemp;
}

Future<double> getTemp() async {
  double temp;
  final Map<String, dynamic> jsonMap = jsonDecode(await jsonString);
  final Map<String, dynamic> currentData = jsonMap["current"];
  temp = currentData["temperature_2m"];
  return temp;
}

Future<double> getPrecipitation() async {
  double precipitation;
  final Map<String, dynamic> jsonMap = jsonDecode(await jsonString);
  final Map<String, dynamic> currentData = jsonMap["current"];
  precipitation = currentData["precipitation"];
  return precipitation;
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double tempFelt = 0;
  double tempReal = 0;
  double precipitation = 0;
  bool isdaytime = true;
  UserLocation location = UserLocation(0, 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Wetter-App"),
          backgroundColor: Colors.lightBlue,
        ),
        body: Center(
          child: Column(
            children: [
              const Spacer(),
              const Spacer(),
              const Spacer(),
              const Spacer(),
              const Text(
                "Stadt: Stuttgart",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const Spacer(),
              Text("Gefühlte Temperatur: $tempFelt°"),
              const Spacer(),
              Text("Temperatur: $tempReal°"),
              const Spacer(),
              Text("Niederschlag: $precipitation mm"),
              const Spacer(),
              Text("Tageszeit: $isdaytime"),
              const Spacer(),
              Text(
                  "Standort: lat: ${location.latitude} long: ${location.longitude}"),
              const Spacer(),
              OutlinedButton(
                  onPressed: () async {
                    location = await getUserLocation();
                    isdaytime = await isDayTime();
                    tempFelt = await getApparentTemp();
                    tempReal = await getTemp();
                    precipitation = await getPrecipitation();

                    setState(() {});
                  },
                  child: const Text("Vorhersage überprüfen")),
              const Spacer(),
              const Spacer(),
              const Spacer(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
