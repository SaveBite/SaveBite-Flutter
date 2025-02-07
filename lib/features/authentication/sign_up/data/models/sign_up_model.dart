import '../../domain/entities/sign_up_entity.dart';

class SignUpModel extends SignUpEntity {
  SignUpModel({
    required super.userName,
    required super.email,
    required super.password,
    required super.passwordConfirmation,
    required super.image,
    required super.type,
    required super.phone,
    required super.answer,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      userName: json['user_name'],
      email: json['email'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
      image: json['image'],
      answer: json['answer'],
      type: json['type'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
    'user_name': userName,
    'email': email,
    'password': password,
    'password_confirmation': passwordConfirmation,
    'image': image,
    'answer': answer,
    'type': type,
    'phone': phone,
  };
}
