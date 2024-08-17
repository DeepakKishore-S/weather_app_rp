import 'package:weather_news_app/model/data_model/weather/weather_data.dart';

class WeatherState {
  final bool isLoading;
  final WeatherData? weatherData;
  final String? errorMessage;

  WeatherState({
    required this.isLoading,
    this.weatherData,
    this.errorMessage,
  });

  factory WeatherState.initial() {
    return WeatherState(isLoading: false);
  }

  WeatherState copyWith({
    bool? isLoading,
    WeatherData? weatherData,
    String? errorMessage,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      weatherData: weatherData ?? this.weatherData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
