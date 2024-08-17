import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_app/model/service/local_db_service/shared_pref_service.dart';
import 'package:weather_news_app/view_model/setting_viewmodel.dart';

final settingsViewModelProvider =
    StateNotifierProvider<SettingsViewModel, String>((ref) {
  return SettingsViewModel(SharedPrefService());
});