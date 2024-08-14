import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '3b2d7998499c78ae4038bd462eb385c3';
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeather(String location) async {
    final response = await http.get(Uri.parse('$apiUrl?q=$location&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}


// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class WeatherService {
//   final String apiKey = '3b2d7998499c78ae4038bd462eb385c3';
//   final String apiUrl = 'https://api.openweathermap.org/data/2.5';

//   Future<Map<String, dynamic>> fetchWeather(String location, String units) async {
//     final response = await http.get(Uri.parse('$apiUrl/forecast?q=$location&appid=$apiKey&units=$units')); // metric and imperial
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load weather data');
//     }
//   }
// }
