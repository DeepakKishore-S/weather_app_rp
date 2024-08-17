import 'package:weather_news_app/model/data_model/news/news_model.dart';

class NewsState {
  final bool isLoading;
  final NewsResponse? newsData;
  final String? errorMessage;

  NewsState({
    required this.isLoading,
    this.newsData,
    this.errorMessage,
  });

  factory NewsState.initial() {
    return NewsState(isLoading: false);
  }

  NewsState copyWith({
    bool? isLoading,
    NewsResponse? newsData,
    String? errorMessage,
  }) {
    return NewsState(
      isLoading: isLoading ?? this.isLoading,
      newsData: newsData ?? this.newsData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
