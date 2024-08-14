

import 'package:weather_news_app/model/service/news_service.dart';
import 'package:weather_news_app/model/service/weather_service.dart';

class WeatherNewsRepository {
  final WeatherService _weatherService;
  final NewsService _newsService;

  WeatherNewsRepository(this._weatherService, this._newsService);

  Future<Map<String, dynamic>> getWeatherData(String location) async {
    return await _weatherService.fetchWeather(location,);
    // return await _weatherService.fetchWeather(location, "metric");
  }

  Future<List<dynamic>> getNewsData(String category) async {
    return await _newsService.fetchNews(category);
  }
}
