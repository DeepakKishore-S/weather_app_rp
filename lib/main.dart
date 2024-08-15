import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_app/view/home/home_screen.dart';
import 'package:weather_news_app/view/settings/settings_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather and News Aggregator',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
        routes: {
          SettingsScreen.route: (context) => const SettingsScreen(),
        },
      ),
    );
  }
}
