import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_app/model/data_model/weather/weather_data.dart';
import 'package:weather_news_app/model/data_model/weather_news_state_model.dart';
import 'package:weather_news_app/model/repository/weather_news_repository.dart';
import 'package:weather_news_app/model/service/news_service.dart';

class WeatherNewsViewModel extends StateNotifier<WeatherNewsState> {
  final WeatherNewsRepository _repository;

  WeatherNewsViewModel(this._repository, NewsService newsService) : super(WeatherNewsState.initial());

  Future<void> fetchWeatherAndNews({required String lat, 
      required String lon, 
      required String units}) async {
    try {
      state = state.copyWith(isLoading: true);
      final WeatherData weatherData = await _repository.getWeatherData(lat: lat, lon: lon, units: units);
      final weatherCondition = weatherData.list[0].weather[0].main.toString().toLowerCase();
      final newsCategory = _getNewsCategory(weatherCondition);
      final newsData = await _repository.getNewsData(newsCategory);
      state = state.copyWith(
        weatherData: weatherData,
        newsData: newsData,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  String _getNewsCategory(String weatherCondition) {
    if (weatherCondition.contains('cold')) {
      return 'general'; // Depressing news
    } else if (weatherCondition.contains('hot')) {
      return 'crime'; // Fear-related news
    } else {
      return 'sports'; // Positive news
    }
  }
}



