import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_news_app/model/data_model/weather/weather_data.dart';

class AppUtils {
  static String capitalizeFirstLetter(String word) {
    if (word.isEmpty) return word; // Return the word as is if it's empty
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  static LinearGradient getWeatherGradient(
      {required String weatherMain, required String weatherDescription}) {
    switch (weatherMain.toLowerCase()) {
      case "clear":
        return LinearGradient(
          colors: [Colors.blue.shade300, Colors.blue.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case "clouds":
        if (weatherDescription.toLowerCase().contains("few")) {
          return LinearGradient(
            colors: [Colors.blue.shade200, Colors.grey.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
        } else if (weatherDescription.toLowerCase().contains("overcast")) {
          return LinearGradient(
            colors: [Colors.grey.shade600, Colors.grey.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
        } else {
          return LinearGradient(
            colors: [Colors.grey.shade400, Colors.grey.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
        }
      case "rain":
        return LinearGradient(
          colors: [Colors.blueGrey.shade400, Colors.blueGrey.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case "thunderstorm":
        return LinearGradient(
          colors: [Colors.deepPurple.shade800, Colors.deepPurple.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case "snow":
        return LinearGradient(
          colors: [Colors.white, Colors.blueGrey.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case "mist":
      case "fog":
        return LinearGradient(
          colors: [Colors.grey.shade200, Colors.grey.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return LinearGradient(
          colors: [Colors.blue.shade200, Colors.blue.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  static List<WeatherInfo> getUniqueEntriesByDate(List<WeatherInfo> entries) {
    final Map<DateTime, WeatherInfo> uniqueEntriesMap = {};

    for (final entry in entries) {
      final DateTime date = DateTime.parse(entry.dt_txt);
      final dateKey = DateTime(date.year, date.month, date.day);
      if (!uniqueEntriesMap.containsKey(dateKey)) {
        uniqueEntriesMap[dateKey] = entry;
      }
    }

    return uniqueEntriesMap.values.toList();
  }

  static String getDayAbbreviation(String date) {
  return DateFormat('EEE').format(DateTime.parse(date));
}

  static String weatherUrl(String iconData) =>
      "https://openweathermap.org/img/wn/${iconData}@2x.png";
}
