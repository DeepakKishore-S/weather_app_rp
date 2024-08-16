import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_app/model/data_model/weather/weather_data.dart';
import 'package:weather_news_app/model/repository/weather_news_repository.dart';
import 'package:weather_news_app/model/data_model/weather_state.dart';

class WeatherViewModel extends StateNotifier<WeatherState> {
  final WeatherNewsRepository _repository;

  WeatherViewModel(this._repository) : super(WeatherState.initial());

  Future<void> fetchWeather({required String lat, required String lon}) async {
    try {
      state = state.copyWith(isLoading: true);
      final WeatherData weatherData = await _repository.getWeatherData(
        lat: lat,
        lon: lon,
        units: state.unit, // Use the units from the state
      );
      state = state.copyWith(weatherData: weatherData, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  String getWeatherCondition() {
    return state.weatherData?.list[0].weather[0].main.toString().toLowerCase() ?? '';
  }

  void updateUnits({required String newUnits, required String lat, required String lon}) async {
    state = state.copyWith(unit: newUnits);
    await fetchWeather(lat: lat, lon: lon); // Automatically fetch weather with the new unit
  }
}
