import 'package:fashion_app/data/local/location/location_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationLocalDataSource {
  Future<Position?> getMyCurrnetLocation();
  Future<List<Placemark>?> getLocationInfromation(
      double latitude, double longitude);
  Future<void> openLocationPageSettings();
}

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  final LocationService _locationService;
  LocationLocalDataSourceImpl(this._locationService);
  @override
  Future<List<Placemark>?> getLocationInfromation(
      double latitude, double longitude) async {
    try {
      return _locationService.getLocationInfromation(latitude, longitude);
    } catch (e) {
      await openLocationPageSettings();
    }
    return null;
  }

  @override
  Future<Position?> getMyCurrnetLocation() async {
    try {
      return _locationService.getMyCurrnetLocation();
    } catch (e) {
      await openLocationPageSettings();
    }
    return null;
  }

  @override
  Future<void> openLocationPageSettings() {
    return _locationService.openLocationPageSettings();
  }
}

openLocationPageSettings() async {
  await Geolocator.openLocationSettings();
}
