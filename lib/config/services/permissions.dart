import 'package:geolocator/geolocator.dart';

import '../../core/functions/function.dart';

abstract class AppPermissions {
  Future<void> checkLocationPermission();
}

class AppPermissionsImpl implements AppPermissions {
  @override
  Future<void> checkLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToastMessage('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showToastMessage('Permissions are denied forever');
    }
  }
}
