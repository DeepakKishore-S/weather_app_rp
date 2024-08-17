import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String unitKey = "selected_unit";

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
}
