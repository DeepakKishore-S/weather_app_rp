import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:weather_news_app/model/data_model/weather_news_state_model.dart';
import 'package:weather_news_app/provider/weather_news_provider.dart';
import 'package:weather_news_app/view/home/home_screen.dart';
import 'package:weather_news_app/view_model/weather_news_viewmodel.dart';

class MockWeatherNewsViewModel extends Mock implements WeatherNewsViewModel {}

void main() {
  testWidgets('HomeScreen displays weather and news data', (WidgetTester tester) async {
    final mockViewModel = MockWeatherNewsViewModel();
    when(mockViewModel.state.weatherData).thenReturn({'main': {'temp': 22.5}});
    when(mockViewModel.state.newsData).thenReturn([
      {'title': 'Breaking News', 'description': 'Details', 'url': 'http://example.com'}
    ]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          weatherNewsProvider.overrideWithValue(mockViewModel),
        ],
        child: MaterialApp(home: HomeScreen()),
      ),
    );

    // Verify that weather data and news are displayed
    expect(find.text('Temperature: 22.5°C'), findsOneWidget);
    expect(find.text('Breaking News'), findsOneWidget);
  });
}

extension on StateNotifierProvider<WeatherNewsViewModel, WeatherNewsState> {
  overrideWithValue(MockWeatherNewsViewModel mockViewModel) {}
}
