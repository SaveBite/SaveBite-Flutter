import 'package:equatable/equatable.dart';

class SignUpEntity extends Equatable {
  final String userName;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String image;
  final int answer;
  final String type;
  final String phone;

  SignUpEntity({
    required this.userName,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.image,
    required this.answer,
    required this.type,
    required this.phone,
  });

  @override
  List<Object?> get props => [
    userName,
    email,
    password,
    passwordConfirmation,
    image,
    answer,
    type,
    phone,
  ];
}
