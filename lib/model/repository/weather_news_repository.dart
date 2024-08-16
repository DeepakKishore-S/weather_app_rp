import 'package:weather_news_app/model/data_model/news/news_model.dart';
import 'package:weather_news_app/model/data_model/weather/weather_data.dart';
import 'package:weather_news_app/model/service/news_service.dart';
import 'package:weather_news_app/model/service/weather_service.dart';

class WeatherNewsRepository {
  final WeatherService _weatherService;
  final NewsService _newsService;

  WeatherNewsRepository(this._weatherService, this._newsService);

  Future<WeatherData> getWeatherData(
      {required String lat, required String lon, required String units}) async {
    dynamic response =
        await _weatherService.fetchWeather(lat: lat, lon: lon, units: units);
    return WeatherData.fromJson(response);
  }

  Future<NewsResponse> getNewsData(String category) async {
    dynamic response = await _newsService.fetchNews(category);
    return NewsResponse.fromJson(response);
  }
}
