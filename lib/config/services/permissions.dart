import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/functions/function.dart';

abstract class AppPermissions {
  Future<void> checkLocationPermission();
  Future<void> openSettings();
  Future<bool> requestPhotosPermission();
  Future<bool> requestCameraPermission();
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

  @override
  Future<void> openSettings() async {
    await openAppSettings();
  }

  @override
  Future<bool> requestPhotosPermission() async {
    return await Permission.storage.request().isGranted;
  }

  @override
  Future<bool> requestCameraPermission() async {
    return await Permission.camera.request().isGranted;
  }
}
