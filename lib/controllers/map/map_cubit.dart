import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:fashion_app/config/services/permissions.dart';
import 'package:fashion_app/config/services/service_locator.dart';

import 'package:fashion_app/data/data_source/local_data_source.dart';

import 'package:fashion_app/domain/entities/account/address.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(this._dataSource) : super(LocationInitial());

  final LocationLocalDataSource _dataSource;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Set<Marker> markers = {};

  CameraPosition get getInitalCameraPosition => _initalCameraPosition;

  final CameraPosition _initalCameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  AddressLocationEntity addressLocation = AddressLocationEntity(
    lat: 0,
    log: 0,
    country: "Conutry",
    state: "State",
    city: "City",
    street: "Street",
  );

  void onMapTap(LatLng latLng) async {
    addMarker(latLng.latitude, latLng.longitude);
    await getLocationInfromation(latLng.latitude, latLng.longitude);
    emit(LocationInfo());
  }

  void addMarker(double latitude, double longitude) {
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId('marker $latitude'),
        position: LatLng(latitude, longitude),
      ),
    );
  }

  Future<void> getLocationInfromation(double latitude, double longitude) async {
    final placemarks =
        await _dataSource.getLocationInfromation(latitude, longitude);
    if (placemarks != null) {
      addressLocation = AddressLocationEntity(
        lat: latitude,
        log: longitude,
        country: placemarks[0].country ?? "",
        state: placemarks[0].locality ?? "",
        city: placemarks[0].subLocality ?? "",
        street: placemarks[0].street ?? "",
      );
    }
    return;
  }

  checkPermission() async {
    await getIt<AppPermissions>().checkLocationPermission();
  }

  getMyCurrnetLocation() async {
    final position = await _dataSource.getMyCurrnetLocation();
    if (position != null) {
      final GoogleMapController controller = await _controller.future;
      await controller.animateCamera(_updateCamera(position));
    }
    return;
  }

  _updateCamera(Position position) {
    return CameraUpdate.newCameraPosition(
      _animateCameraToPosition(position.latitude, position.longitude),
    );
  }

  _animateCameraToPosition(double latitude, double longitude) {
    return CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(latitude, longitude),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414,
    );
  }
}
