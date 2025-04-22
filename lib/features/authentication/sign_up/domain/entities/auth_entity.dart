import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String token;
  final String otpToken;
  final bool isVerified;
  final String name;
  final String email;
  final String type;

  const AuthEntity({
    required this.token,
    required this.otpToken,
    required this.isVerified,
    required this.name,
    required this.email,
    required this.type,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [token, otpToken, isVerified, name, email, type];
}
