import 'package:weather_news_app/model/data_model/weather/weather_data.dart';

class WeatherState {
  final bool isLoading;
  final WeatherData? weatherData;
  final String? errorMessage;
  final String unit;

  WeatherState({
    required this.isLoading,
    this.weatherData,
    this.errorMessage,
    this.unit = "metric"
  });

  factory WeatherState.initial() {
    return WeatherState(isLoading: false);
  }

  WeatherState copyWith({
    bool? isLoading,
    WeatherData? weatherData,
    String? errorMessage,
    String? unit
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      weatherData: weatherData ?? this.weatherData,
      errorMessage: errorMessage ?? this.errorMessage,
      unit: unit ?? this.unit
    );
  }
}
