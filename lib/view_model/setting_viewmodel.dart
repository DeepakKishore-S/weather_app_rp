import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_app/model/service/local_db_service/shared_pref_service.dart';

class SettingsViewModel extends StateNotifier<String> {
  final SharedPrefService _unitModel;

  SettingsViewModel(this._unitModel) : super("metric");

  Future<void> loadUnit() async {
    final isCelsius = await _unitModel.loadUnit();
    state = isCelsius ?? "metric";
  }

  Future<void> updateUnit(String isCelsius) async {
    state = isCelsius;
    await _unitModel.saveUnit(isCelsius);
  }

  String getUnitString() {
    return state;
  }
}
