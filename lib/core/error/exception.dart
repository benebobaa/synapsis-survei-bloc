class ServerException implements Exception {}

class BadRequestException implements Exception {
  final String message;

  BadRequestException({required this.message});
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException({required this.message});
}

class LocalDatabaseException implements Exception {}

class UnauthenticatedException implements Exception {}

class FingerprintException implements Exception {}


