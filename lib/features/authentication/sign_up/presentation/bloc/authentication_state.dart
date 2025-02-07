part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

/// Initial state
class AuthInitial extends AuthenticationState {}

/// Loading state during authentication actions
class LoadingState extends AuthenticationState {}

///  State when sign-up is successful
class SignedUpSuccessState extends AuthenticationState {
  final AuthEntity authEntity;

  const SignedUpSuccessState({required this.authEntity});

  @override
  List<Object> get props => [authEntity];
}

///  State when an error occurs
class ErrorAuthenticationState extends AuthenticationState {
  final String message;

  const ErrorAuthenticationState({required this.message});

  @override
  List<Object> get props => [message];
}

///  State when a user is authenticated
class UserAuthState extends AuthenticationState {
  final String token;

  const UserAuthState(this.token);

  @override
  List<Object> get props => [token];
}
