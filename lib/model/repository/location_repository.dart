import 'package:geolocator/geolocator.dart';
import 'package:weather_news_app/model/service/location_service.dart';

class LocationRepository {
  final LocationService _locationService;

  LocationRepository(this._locationService);

  Future<Position> getCurrentLocation() async {
    return await _locationService.getCurrentLocation();
  }

  Future<void> openLocationSettings() async {
    await _locationService.openLocationSettings();
  }
}
