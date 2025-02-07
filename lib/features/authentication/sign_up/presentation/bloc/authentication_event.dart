part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

/// ✅ Event for signing up a user
class SignUpEvent extends AuthenticationEvent {
  final SignUpEntity signUpEntity;

  const SignUpEvent({required this.signUpEntity});

}

