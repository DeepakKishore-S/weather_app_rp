import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_news_app/model/repository/location_repository.dart';

class LocationViewModel extends StateNotifier<AsyncValue<Position?>> {
  final LocationRepository _locationRepository;

  LocationViewModel(this._locationRepository)
      : super(const AsyncValue.loading()) {
    checkLocationPermission();
  }

  Future<void> checkLocationPermission() async {
    try {
      final permission = await Geolocator.checkPermission();
      // if (permission == LocationPermission.always ||
      //     permission == LocationPermission.whileInUse) {
        final position = await _locationRepository.getCurrentLocation();
        state = AsyncValue.data(position);
      // } else {
      //   throw ('Location permission not granted');
      // }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> openLocationSettings() async {
    try {
      await _locationRepository.openLocationSettings();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
