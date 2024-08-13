import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_news_app/provider/weather_news_provider.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);
    final weatherNewsState = ref.watch(weatherNewsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Weather and News Aggregator')),
      body: Column(
        children: [
          if (weatherNewsState.isLoading)
            CircularProgressIndicator()
          else if (weatherNewsState.errorMessage != null)
            Text('Error: ${weatherNewsState.errorMessage}')
          else if (weatherNewsState.weatherData != null &&
              weatherNewsState.newsData != null) ...[
            Text('Location: $location'),
            Text('Temperature: ${weatherNewsState.weatherData!['main']['temp']}°C'),
            Text('Condition: ${weatherNewsState.weatherData!['weather'][0]['description']}'),
            Expanded(
              child: ListView.builder(
                itemCount: weatherNewsState.newsData!.length,
                itemBuilder: (context, index) {
                  final article = weatherNewsState.newsData![index];
                  return ListTile(
                    title: Text(article['title']),
                    subtitle: Text(article['description'] ?? ''),
                    onTap: () => _launchURL(article['url']),
                  );
                },
              ),
            ),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(weatherNewsProvider.notifier).fetchWeatherAndNews(location),
        child: Icon(Icons.refresh),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
