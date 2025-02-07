import 'package:equatable/equatable.dart';

import '../strings/messages.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

// 📌 Specific Failures
class OfflineFailure extends Failure {
  const OfflineFailure() : super(message: OFFLINE_FAILURE_MESSAGE);
}

class ServerFailure extends Failure {
  ServerFailure({required String message}) : super(message: message);
}

class CacheFailure extends Failure {
  const CacheFailure({String message = CACHE_FAILURE_MESSAGE}) : super(message: message);
}

class ExistedAccountFailure extends Failure {
  const ExistedAccountFailure() : super(message: EXISTED_ACCOUNT_FAILURE_MESSAGE);
}

class NoUserFailure extends Failure {
  const NoUserFailure() : super(message: NO_USER_FAILURE_MESSAGE);
}

class WrongPasswordFailure extends Failure {
  const WrongPasswordFailure() : super(message: WRONG_PASSWORD_FAILURE_MESSAGE);
}

class UnmatchedPassFailure extends Failure {
  const UnmatchedPassFailure() : super(message: UNMATCHED_PASSWORD_FAILURE_MESSAGE);
}

class NotLoggedInFailure extends Failure {
  const NotLoggedInFailure() : super(message: "User is not logged in.");
}

class EmailVerifiedFailure extends Failure {
  const EmailVerifiedFailure() : super(message: "Email is not verified.");
}

class TooManyRequestsFailure extends Failure {
  const TooManyRequestsFailure() : super(message: TOO_MANY_REQUESTS_FAILURE_MESSAGE);
}

class WeakPasswordFailure extends Failure {
  const WeakPasswordFailure() : super(message: WEAK_PASS_FAILURE_MESSAGE);
}

class ValidationFailure extends Failure {
  final List<String> errors;

   ValidationFailure(this.errors)
      : super(message: errors.isNotEmpty ? errors.join("\n") : VALIDATION_ERROR_MESSAGE);

  @override
  List<Object?> get props => [message, errors];
}