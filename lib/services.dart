import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'da37e8f99fef5becb04f1b648bb88929';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeather(String cityName) async {
    final response =
        await http.get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Data yüklenirken bir sorun oluştu!');
    }
  }
}
