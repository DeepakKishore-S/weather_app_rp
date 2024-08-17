import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_app/model/service/local_db_service/shared_pref_service.dart';

class SettingsViewModel extends StateNotifier<String> {
  final SharedPrefService _sharedPrefService;

  SettingsViewModel(this._sharedPrefService) : super("metric");

  Future<void> loadUnit() async {
    final isCelsius = await _sharedPrefService.loadUnit();
    state = isCelsius ?? "metric";
  }

  Future<void> updateUnit(String unit) async {
    state = unit;
    await _sharedPrefService.saveUnit(unit);
  }

  String getUnitString() {
    return state;
  }

  Future<List<String>> loadInterestedCategories() async {
    return await _sharedPrefService.loadInterestedCategories() ?? [];
  }

  Future<void> updateInterestedCategories(List<String> categories) async {
    await _sharedPrefService.saveInterestedCategories(categories);
  }
}
