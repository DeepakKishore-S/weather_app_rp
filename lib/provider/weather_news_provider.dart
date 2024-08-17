import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_app/model/data_model/news_state.dart';
import 'package:weather_news_app/model/data_model/weather_state.dart';
import 'package:weather_news_app/model/repository/weather_news_repository.dart';
import 'package:weather_news_app/model/service/api_service/news_service.dart';
import 'package:weather_news_app/model/service/api_service/weather_service.dart';
import 'package:weather_news_app/view_model/collapse_viewmodel.dart';
import 'package:weather_news_app/view_model/news_viewmodel.dart';
import 'package:weather_news_app/view_model/weather_viewmodel.dart';

final weatherServiceProvider = Provider((ref) => WeatherService());
final newsServiceProvider = Provider((ref) => NewsService());
final collapseViewModelProvider =
    StateNotifierProvider<CollapseViewModel, bool>(
  (ref) => CollapseViewModel(),
);

final weatherNewsRepositoryProvider = Provider((ref) {
  final weatherService = ref.watch(weatherServiceProvider);
  final newsService = ref.watch(newsServiceProvider);
  return WeatherNewsRepository(weatherService, newsService);
});

final weatherProvider = StateNotifierProvider<WeatherViewModel, WeatherState>(
  (ref) {
    final repository = ref.watch(weatherNewsRepositoryProvider);
    return WeatherViewModel(repository);
  },
);

final newsProvider = StateNotifierProvider<NewsViewModel, NewsState>(
  (ref) {
    final repository = ref.watch(weatherNewsRepositoryProvider);
    return NewsViewModel(repository);
  },
);

final locationProvider = StateProvider<String>((ref) => 'Chennai');
