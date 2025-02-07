import 'package:save_bite/features/authentication/verification/domain/entity/resend_code_entity.dart';

class ResendCodeModel extends ResendCodeEntity {
  ResendCodeModel({
    required super.email,
  });

  factory ResendCodeModel.fromJson(Map<String, dynamic> json) {
    return ResendCodeModel(
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
