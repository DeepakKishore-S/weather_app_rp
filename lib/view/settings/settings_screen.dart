import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_news_app/provider/location_provider.dart';
import 'package:weather_news_app/provider/weather_news_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  static const String route = '/settings';

  const SettingsScreen({super.key});
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool isCelsius = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCelsius = prefs.getBool('isCelsius') ?? true;
    });
  }

  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isCelsius', isCelsius);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        children: [
          SwitchListTile(
            title: Text(
                'Temperature Unit: ${isCelsius ? "Celsius" : "Fahrenheit"}'),
            value: isCelsius,
            onChanged: (value) {
              onUnitChanged(value? "metric": "imperial");
              setState(() {
                isCelsius = value;
                _saveSettings();
              });
            },
          ),
          // Add more settings here
        ],
      ),
    );
  }

  void onUnitChanged(String newUnit) {
    ref.read(collapseViewModelProvider.notifier).toggleCollapse(false);
  final locationState = ref.read(locationViewModelProvider);
  final weatherViewModel = ref.read(weatherProvider.notifier);

  if (locationState.value != null) {
    weatherViewModel.updateUnits(
      newUnits: newUnit,
      lat: locationState.value!.latitude.toString(),
      lon: locationState.value!.longitude.toString(),
    );
  }
}

}
