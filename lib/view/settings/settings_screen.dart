import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        children: [
          SwitchListTile(
            title: Text(
                'Temperature Unit: ${isCelsius ? "Celsius" : "Fahrenheit"}'),
            value: isCelsius,
            onChanged: (value) {
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
}
