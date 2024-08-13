import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_app/view/home/home_screen.dart';
import 'package:weather_news_app/view/settings/settings_screen.dart';


void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather and News Aggregator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      routes: {
       SettingsScreen.route : (context) => SettingsScreen(),
      },
    );
  }
}
