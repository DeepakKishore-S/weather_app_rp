import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_news_app/provider/location_provider.dart';
import 'package:weather_news_app/res/AppContextExtension.dart';
import 'package:weather_news_app/view/home/widgets/app_bar_widget.dart';
import 'package:weather_news_app/view/home/widgets/news_body_widget.dart';
import 'package:weather_news_app/view/home/widgets/weather_info_widget.dart';
import 'package:weather_news_app/provider/weather_news_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String route = "/home";
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Listener to handle scrolling and collapsing behavior
    _scrollController.addListener(() {
      final isCollapsed = _scrollController.offset >
          context.resources.screenHeight * 0.5;
      ref.read(collapseViewModelProvider.notifier).toggleCollapse(isCollapsed);
    });

    // Initial fetch of weather and news data
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final locationState = ref.read(locationViewModelProvider);
      fetchWeatherAndNews(ref,
          lat: locationState.value!.latitude.toString(),
          lon: locationState.value!.longitude.toString(),
          units: "metric");
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherProvider);
    final newsState = ref.watch(newsProvider);
    final isCollapsed = ref.watch(collapseViewModelProvider);

    return Scaffold(
      body: Stack(
        children: [
          if (weatherState.isLoading || newsState.isLoading)
            Center(
                child: Lottie.asset(
              "assets/lottie/loader.json",
              height: 100,
              errorBuilder: (context, error, stackTrace) =>
                  const CircularProgressIndicator(),
            ))
          else ...[
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  if (weatherState.isLoading)
                    const SizedBox.shrink()
                  else if (weatherState.errorMessage != null)
                    _buildErrorWidget(weatherState.errorMessage!)
                  else if (weatherState.weatherData != null &&
                      newsState.newsData != null)
                    WeatherInfoWidget(
                      weatherState: weatherState,
                      isCollapsed: isCollapsed,
                    ),
                  NewsBodyWidget(newsState: newsState),
                ],
              ),
            ),
            if (weatherState.weatherData != null)
              AppBarWidget(
                isCollapsed: isCollapsed,
                weatherState: weatherState,
              ),
          ]
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final locationState = ref.read(locationViewModelProvider);
          fetchWeatherAndNews(ref,
              lat: locationState.value!.latitude.toString(),
              lon: locationState.value!.longitude.toString(),
              units: "metric");
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Error: $errorMessage',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Future<void> fetchWeatherAndNews(WidgetRef ref,
      {required String lat, required String lon, required String units}) async {
    ref.read(collapseViewModelProvider.notifier).toggleCollapse(false);
    try {
      // Fetch weather data
      final weatherViewModel = ref.read(weatherProvider.notifier);
      await weatherViewModel.fetchWeather(lat: lat, lon: lon);

      // Retrieve weather condition for news
      final weatherCondition = weatherViewModel.getWeatherCondition();

      // Fetch news data based on weather condition
      final newsViewModel = ref.read(newsProvider.notifier);
      await newsViewModel.fetchNews(weatherCondition);
    } catch (e) {
      debugPrint('An error occurred: $e');
    }
  }
}
