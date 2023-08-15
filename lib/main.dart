import 'package:flutter/material.dart';

import 'weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Famous Weather Application',
      home: WeatherScreen(),
    );
  }
}
