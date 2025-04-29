import 'package:equatable/equatable.dart';

class CheckCodeResponseEntity extends Equatable {
  final String name;
  final String email;
  final String type;
  final bool is_verified;
  final String token;

  const CheckCodeResponseEntity(
      {required this.token,
      required this.is_verified,
      required this.type,
      required this.email,
      required this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [token, is_verified, type, email, name];
}
