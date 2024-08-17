import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_app/provider/location_provider.dart';
import 'package:weather_news_app/provider/settings_provider.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final unit = ref.watch(settingsViewModelProvider);

      setState(() {
        isCelsius = unit == "metric";
      });
    });
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
              onUnitChanged(value ? "metric" : "imperial");
              setState(() {
                isCelsius = value;
              });
            },
          ),
        ],
      ),
    );
  }

  void onUnitChanged(String newUnit) {
    final settingsViewModel = ref.read(settingsViewModelProvider.notifier);
    settingsViewModel.updateUnit(newUnit);
    ref.read(collapseViewModelProvider.notifier).toggleCollapse(false);
    final locationState = ref.read(locationViewModelProvider);
    final weatherViewModel = ref.read(weatherProvider.notifier);

    if (locationState.value != null) {
      weatherViewModel.updateUnits(
        units: newUnit,
        lat: locationState.value!.latitude.toString(),
        lon: locationState.value!.longitude.toString(),
      );
    }
  }
}
