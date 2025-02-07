import 'package:save_bite/features/authentication/sign_up/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  AuthModel({
    required super.token,
    required super.otpToken,
    required super.isVerified,
    required super.name,
    required super.email,
    required super.type,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
        token: json['token'] ?? '',
        otpToken: json['otp_token'] ?? '',
        name: json['name'] ?? '',
        email: json['email'],
        type: json['type'],
        isVerified: (json['is_verified'] == 1) // ✅ Convert int to bool to handle null value
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'otpToken': otpToken,
      'isVerified': isVerified,
      'name': name,
      'email': email,
      'type': type,
    };
  }
}
