import '../strings/messages.dart';

class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => "ServerException: $message";
}

class CacheException implements Exception {
  final String message;
  CacheException({this.message = CACHE_FAILURE_MESSAGE});
}

class OfflineException implements Exception {}

class WeakPassException implements Exception {}

class ExistedAccountException implements Exception {}

class NoUserException implements Exception {}

class WrongPasswordException implements Exception {}

class TooManyRequestsException implements Exception {}

class ValidationException implements Exception {
  final List<String> errors;
  ValidationException(this.errors);

  @override
  String toString() => "ValidationException: ${errors.join(', ')}";
}