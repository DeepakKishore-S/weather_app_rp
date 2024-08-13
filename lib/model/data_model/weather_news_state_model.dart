class WeatherNewsState {
  final bool isLoading;
  final Map<String, dynamic>? weatherData;
  final List<dynamic>? newsData;
  final String? errorMessage;

  WeatherNewsState({
    required this.isLoading,
    this.weatherData,
    this.newsData,
    this.errorMessage,
  });

  factory WeatherNewsState.initial() {
    return WeatherNewsState(isLoading: false);
  }

  WeatherNewsState copyWith({
    bool? isLoading,
    Map<String, dynamic>? weatherData,
    List<dynamic>? newsData,
    String? errorMessage,
  }) {
    return WeatherNewsState(
      isLoading: isLoading ?? this.isLoading,
      weatherData: weatherData ?? this.weatherData,
      newsData: newsData ?? this.newsData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}