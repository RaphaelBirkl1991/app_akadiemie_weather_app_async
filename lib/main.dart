import 'package:flutter/material.dart';
import 'package:weather_app_asynchronous/weather_data.dart';
import 'package:weather_app_asynchronous/weather_repo.dart';

void main() async {
  // WeatherData weatherData = WeatherData(
  //     tempFelt: await getApparentTemp(),
  //     temp: await getTemp(),
  //     precipitation: await getPrecipitation(),
  //     isDayTime: await isDayTime(),
  //     location: await getUserLocation());

  runApp(const MainApp());
}

// Future<UserLocation> getUserLocation() async {
//   final Map<String, dynamic> jsonMap = jsonDecode(await jsonString);
//   double longitude = jsonMap["longitude"];
//   double latitude = jsonMap["latitude"];
//   final jsonLocation = UserLocation(latitude, longitude);
//   return jsonLocation;
// }

// Future<bool> isDayTime() async {
//   bool isDayTime;
//   int returnValue;
//   final Map<String, dynamic> jsonMap = jsonDecode(await jsonString);
//   final Map<String, dynamic> currentData = jsonMap["current"];
//   returnValue = currentData["is_day"];
//   returnValue == 1 ? isDayTime = true : isDayTime = false;
//   return isDayTime;
// }

// Future<double> getApparentTemp() async {
//   double apparentTemp;
//   final Map<String, dynamic> jsonMap = jsonDecode(await jsonString);
//   final Map<String, dynamic> currentData = jsonMap["current"];
//   apparentTemp = currentData["apparent_temperature"];
//   return apparentTemp;
// }

// Future<double> getTemp() async {
//   double temp;
//   final Map<String, dynamic> jsonMap = jsonDecode(await jsonString);
//   final Map<String, dynamic> currentData = jsonMap["current"];
//   temp = currentData["temperature_2m"];
//   return temp;
// }

// Future<double> getPrecipitation() async {
//   double precipitation;
//   final Map<String, dynamic> jsonMap = jsonDecode(await jsonString);
//   final Map<String, dynamic> currentData = jsonMap["current"];
//   precipitation = currentData["precipitation"];
//   return precipitation;
// }

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // double tempFelt = 0;
  // double tempReal = 0;
  // double precipitation = 0;
  // bool isdaytime = true;
  // UserLocation location = UserLocation(0, 0);

  WeatherRepository repository = WeatherRepository();
  WeatherData? weatherData;

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
              //    Text("Gefühlte Temperatur: $tempFelt°"),
              Text(weatherData == null
                  ? "loading..."
                  : "Gefühlte Temp ${weatherData?.tempFelt.toString()}" ?? ""),
              const Spacer(),
              //  Text("Temperatur: $tempReal°"),
              Text(weatherData == null
                  ? "loading..."
                  : "Temperatur ${weatherData?.temp.toString()}" ?? ""),
              const Spacer(),
              //   Text("Niederschlag: $precipitation mm"),
              Text(weatherData == null
                  ? "loading..."
                  : "Niederschlag ${weatherData?.precipitation.toString()}" ??
                      ""),
              const Spacer(),
              //   Text("Tageszeit: $isdaytime"),
              Text(weatherData == null
                  ? "loading..."
                  : "Tag/Nacht ${weatherData?.isDayTime.toString()}" ?? ""),
              const Spacer(),
              //  Text("Standort: lat: ${location.latitude} long: ${location.longitude}"),
              Text(weatherData == null
                  ? "loading..."
                  : "lat: ${weatherData?.latitude.toString()} long: ${weatherData?.longitude.toString()}" ??
                      ""),
              const Spacer(),
              OutlinedButton(
                  onPressed: () async {
                    // location = await getUserLocation();
                    // isdaytime = await isDayTime();
                    // tempFelt = await getApparentTemp();
                    // tempReal = await getTemp();
                    // precipitation = await getPrecipitation();
                    weatherData = await repository.getWeatherData();

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
