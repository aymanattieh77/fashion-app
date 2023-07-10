import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  Future<Position?> getMyCurrnetLocation();
  Future<List<Placemark>?> getLocationInfromation(
      double latitude, double longitude);
  Future<void> openLocationPageSettings();
}
