import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_app/model/repository/weather_news_repository.dart';
import 'package:weather_news_app/model/data_model/news_state.dart';

class NewsViewModel extends StateNotifier<NewsState> {
  final WeatherNewsRepository _repository;

  NewsViewModel(this._repository) : super(NewsState.initial());

  Future<void> fetchNews(String weatherCondition) async {
    try {
      state = state.copyWith(isLoading: true);
      final newsCategory = _getNewsCategory(weatherCondition);
      final newsData = await _repository.getNewsData(newsCategory);
      state = state.copyWith(newsData: newsData, isLoading: false);
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
