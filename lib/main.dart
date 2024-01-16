import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
              const Text("Gefühlte Temperatur: -10°"),
              const Spacer(),
              const Text("Temperatur: -4°"),
              const Spacer(),
              const Text("Niederschlag: 15.00mm"),
              const Spacer(),
              const Text("Tageszeit: Tag"),
              const Spacer(),
              const Text("Standort: lat: 48.783, long: 9.183"),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {}, child: const Text("Vorhersage überprüfen")),
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
