part of 'map_cubit.dart';

abstract class MapState {
  const MapState();
}

class LocationInitial extends MapState {}

class LocationInfo extends MapState {}

class LocationMarker extends MapState {}
