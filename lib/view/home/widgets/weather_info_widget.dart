import 'package:flutter/material.dart';
import 'package:weather_news_app/model/data_model/weather_state.dart';
import 'package:weather_news_app/res/utils.dart';

class WeatherInfoWidget extends StatelessWidget {
  final WeatherState weatherState;
  final bool isCollapsed;

  const WeatherInfoWidget({
    super.key,
    required this.weatherState,
    required this.isCollapsed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        gradient: AppUtils.getWeatherGradient(
          weatherDescription: weatherState.weatherData!.list[0].weather[0].main,
          weatherMain: weatherState.weatherData!.list[0].weather[0].description,
        ),
      ),
      child: Center(
        child: isCollapsed
            ? Container()
            : SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Expanded Title',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Location: ${weatherState.weatherData!.city.name}'),
                    Text(
                        'Temperature: ${weatherState.weatherData!.list[0].main.temp}°C'),
                    Text(
                        'Condition: ${weatherState.weatherData!.list[0].weather[0].description}'),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }
}
