import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<InternetConnectionStatus> get connectionStatus;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker _checker;
  NetworkInfoImpl(this._checker);
  @override
  Future<bool> get isConnected async => _checker.hasConnection;

  @override
  Future<InternetConnectionStatus> get connectionStatus async =>
      _checker.connectionStatus;
}
