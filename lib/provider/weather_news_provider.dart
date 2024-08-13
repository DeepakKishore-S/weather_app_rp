import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_app/model/data_model/weather_news_state_model.dart';
import 'package:weather_news_app/model/repository/weather_news_repository.dart';
import 'package:weather_news_app/model/service/news_service.dart';
import 'package:weather_news_app/model/service/weather_service.dart';
import 'package:weather_news_app/view_model/weather_news_viewmodel.dart';

final weatherServiceProvider = Provider((ref) => WeatherService());
final newsServiceProvider = Provider((ref) => NewsService());

final weatherNewsRepositoryProvider = Provider((ref) {
  final weatherService = ref.watch(weatherServiceProvider);
  final newsService = ref.watch(newsServiceProvider);
  return WeatherNewsRepository(weatherService, newsService);
});

final weatherNewsProvider = StateNotifierProvider<WeatherNewsViewModel, WeatherNewsState>(
  (ref) {
    final repository = ref.watch(weatherNewsRepositoryProvider);
    final newsService = ref.watch(newsServiceProvider);
    return WeatherNewsViewModel(repository,newsService);
  },
);

final locationProvider = StateProvider<String>((ref) => 'Chennai');


