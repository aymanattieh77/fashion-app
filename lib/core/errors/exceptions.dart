class ServerException implements Exception {
  final String message;
  ServerException({
    required this.message,
  });
}

class AuthException implements Exception {
  final String message;
  AuthException({
    required this.message,
  });
}

class FireException implements Exception {
  final String message;
  FireException({
    required this.message,
  });
}
