import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'services.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  String cityName = '';
  Map<String, dynamic> currentWeather = {};
  List<Map<String, dynamic>> hourlyWeather = [];

  @override
  void initState() {
    super.initState();
    _fetchLocationAndWeather();
  }

  Future<void> _fetchLocationAndWeather() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
      cityName = placemarks[0].locality ?? 'Unknown';
    });

    _fetchWeatherData(cityName);
  }

  Future<void> _fetchWeatherData(String city) async {
    try {
      var data = await _weatherService.fetchWeather(city);
      //var hourlyData = await _weatherService.fetchHourlyWeather(city); // eklenmesi gerekiyor.

      setState(() {
        currentWeather = data;
        //hourlyWeather = hourlyData; eklenmesi gerekiyor.
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Famous Weather",
            style: GoogleFonts.lilitaOne(fontSize: 35),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: 1000,
                  width: 1000,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1616843412755-356b9f8b30b4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGRhcmslMjBjbG91ZHxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: havaDurumSayfasi(),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Mevcut Konum: $cityName',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    currentWeather.isNotEmpty
                        ? Column(
                            children: [
                              Text(
                                '${currentWeather['weather'][0]['main']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                '${currentWeather['main']['temp']} °C',
                                style: TextStyle(fontSize: 32),
                              ),
                            ],
                          )
                        : CircularProgressIndicator(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class havaDurumSayfasi extends StatelessWidget {
  const havaDurumSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
