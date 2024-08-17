import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_news_app/provider/location_provider.dart';
import 'package:weather_news_app/provider/settings_provider.dart';
import 'package:weather_news_app/provider/weather_news_provider.dart';
import 'package:weather_news_app/res/AppContextExtension.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  static const String route = '/settings';

  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool isCelsius = true;
  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final unit = ref.watch(settingsViewModelProvider);
      final categories = await ref
          .read(settingsViewModelProvider.notifier)
          .loadInterestedCategories();

      setState(() {
        isCelsius = unit == "metric";
        selectedCategories = categories;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.roboto(
            fontSize: context.resources.dimension.bigText,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildTemperatureUnitSwitch(),
            const SizedBox(height: 30),
            _buildCategorySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTemperatureUnitSwitch() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SwitchListTile(
        title: Text(
          'Temperature Unit: ${isCelsius ? "Celsius" : "Fahrenheit"}',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            // color: Colors.blue,
          ),
        ),
        value: isCelsius,
        onChanged: (value) {
          onUnitChanged(value ? "metric" : "imperial");
          setState(() {
            isCelsius = value;
          });
        },
        activeColor: Colors.blue,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interested Categories:',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              // color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: _buildCategorySelection(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCategorySelection() {
    final availableCategories = [
      "Technology",
      "Sports",
      "Health",
      "Science",
      "Entertainment"
    ];
    return availableCategories.map((category) {
      return Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: CheckboxListTile(
          activeColor: Colors.blue,
          title: Text(category, style: GoogleFonts.roboto(fontSize: 16)),
          value: selectedCategories.contains(category),
          onChanged: (bool? isChecked) {
            setState(() {
              if (isChecked == true) {
                selectedCategories.add(category);
              } else {
                selectedCategories.remove(category);
              }
            });
            _saveCategories();
          },
        ),
      );
    }).toList();
  }

  void _saveCategories() {
    ref
        .read(settingsViewModelProvider.notifier)
        .updateInterestedCategories(selectedCategories);
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
