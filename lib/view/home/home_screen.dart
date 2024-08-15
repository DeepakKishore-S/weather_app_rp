import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_news_app/model/data_model/weather_news_state_model.dart';
import 'package:weather_news_app/provider/weather_news_provider.dart';
import 'package:weather_news_app/res/AppContextExtension.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  
  ScrollController _scrollController = ScrollController();
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 200 && !_isCollapsed) {
        setState(() {
          _isCollapsed = true;
        });
      } else if (_scrollController.offset <= 200 && _isCollapsed) {
        setState(() {
          _isCollapsed = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationProvider);
  final weatherNewsState = ref.watch(weatherNewsProvider);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: NetworkImage('https://source.unsplash.com/random/800x600'),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: Center(
                    child: _isCollapsed
                        ? Container()
                        : Container(
                          color: Colors.red,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Expanded Title',
                                  style: TextStyle(
                                    // color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.favorite, color: Colors.black),
                                    SizedBox(width: 10),
                                    Icon(Icons.share, color: Colors.black12),
                                    SizedBox(width: 10),
                                    Icon(Icons.more_vert, color: Colors.black),
                                  ],
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                        ),
                  ),
                ),
                body(weatherNewsState, location)
              ],
            ),
          ),
          _buildAppBar(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref
            .read(weatherNewsProvider.notifier)
            .fetchWeatherAndNews(lat: "13",lon: "80",units: "metric"),
        child: const Icon(Icons.refresh),
      ),
    );

  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildAppBar() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      color: _isCollapsed ? Colors.blue : Colors.transparent,
      height: 80.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
        child: Row(
          children: [
            Icon(Icons.arrow_back, color: _isCollapsed ? Colors.white : Colors.transparent),
            SizedBox(width: 10),
            Text(
              _isCollapsed ? 'Collapsed Title' : '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.settings, color: _isCollapsed ? Colors.white : Colors.transparent),
          ],
        ),
      ),
    );
  }

  Widget body(weatherNewsState, location) {
    return Column(
      children: [
        if (weatherNewsState.isLoading)
          const CircularProgressIndicator()
        else if (weatherNewsState.errorMessage != null)
          Text('Error: ${weatherNewsState.errorMessage}')
        else if (weatherNewsState.weatherData != null &&
            weatherNewsState.newsData != null &&
            weatherNewsState is WeatherNewsState) ...[
          Text('Location: $location'),
          Text(
              'Temperature: ${weatherNewsState.weatherData!.list[0].main.temp}°C'),
          Text(
              'Condition: ${weatherNewsState.weatherData!.list[0].weather[0].description}'),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
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
        ],
      ],
    );
  }
}
