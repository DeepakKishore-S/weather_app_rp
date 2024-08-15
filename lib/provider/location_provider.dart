import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_news_app/model/repository/location_repository.dart';
import 'package:weather_news_app/model/service/location_service.dart';
import 'package:weather_news_app/view_model/location_viewmodel.dart';

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final locationService = ref.watch(locationServiceProvider);
  return LocationRepository(locationService);
});

final locationViewModelProvider = StateNotifierProvider<LocationViewModel, AsyncValue<Position?>>((ref) {
  final locationRepository = ref.watch(locationRepositoryProvider);
  return LocationViewModel(locationRepository);
});
