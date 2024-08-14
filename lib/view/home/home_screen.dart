import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_news_app/provider/weather_news_provider.dart';
import 'package:weather_news_app/view/settings/settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);
    final weatherNewsState = ref.watch(weatherNewsProvider);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,

              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  // Check the shrink offset to determine the size of the SliverAppBar
                  var top = constraints.biggest.height;
                  bool isExpanded = top > kToolbarHeight;

                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: isExpanded
                        ? Text('Expanded Title')
                        : Text('Collapsed Title'),
                    background: Image.network(
                            'https://via.placeholder.com/400x200',
                            fit: BoxFit.cover,
                          ),
                  );
                },
              ),
            ),
          ];
        },
        body: body(weatherNewsState, location),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref
            .read(weatherNewsProvider.notifier)
            .fetchWeatherAndNews(location),
        child: const Icon(Icons.refresh),
      ),
      // appBar: AppBar(
      //   title: const Text('Weather and News Aggregator'),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           Navigator.of(context).pushNamed(SettingsScreen.route);
      //         },
      //         icon: const Icon(Icons.settings))
      //   ],
      // ),
      // body: body(weatherNewsState, location),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => ref
      //       .read(weatherNewsProvider.notifier)
      //       .fetchWeatherAndNews(location),
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget body(weatherNewsState, location){
    return Column(
        children: [
          if (weatherNewsState.isLoading)
            const CircularProgressIndicator()
          else if (weatherNewsState.errorMessage != null)
            Text('Error: ${weatherNewsState.errorMessage}')
          else if (weatherNewsState.weatherData != null &&
              weatherNewsState.newsData != null) ...[
            Text('Location: $location'),
            Text(
                'Temperature: ${weatherNewsState.weatherData!['main']['temp']}°C'),
            Text(
                'Condition: ${weatherNewsState.weatherData!['weather'][0]['description']}'),
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
      );
  }
}
