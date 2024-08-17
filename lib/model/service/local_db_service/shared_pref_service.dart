import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String unitKey = "selected_unit";
  static const String categoriesKey = "interested_categories";

  // Save unit to SharedPreferences
  Future<void> saveUnit(String unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(unitKey, unit);
  }

  // Load unit from SharedPreferences
  Future<String?> loadUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(unitKey);
  }

  // Save interested categories to SharedPreferences
  Future<void> saveInterestedCategories(List<String> categories) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(categoriesKey, categories);
  }

  // Load interested categories from SharedPreferences
  Future<List<String>?> loadInterestedCategories() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(categoriesKey);
  }
}
