import 'package:fashion_app/data/local/location/location_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationServiceImpl implements LocationService {
  @override
  Future<List<Placemark>> getLocationInfromation(
      double latitude, double longitude) async {
    return await placemarkFromCoordinates(
      latitude,
      longitude,
      localeIdentifier: 'en',
    );
  }

  @override
  Future<Position> getMyCurrnetLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Future<void> openLocationPageSettings() async {
    await Geolocator.openLocationSettings();
  }
}
