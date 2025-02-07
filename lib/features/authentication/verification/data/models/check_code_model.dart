import 'package:save_bite/features/authentication/verification/domain/entity/check_code_entity.dart';

class CheckCodeModel extends CheckCodeEntity {
  CheckCodeModel(
      {required super.otp,
        required super.otp_token,});

  factory CheckCodeModel.fromJson(Map<String, dynamic> json) {
    return CheckCodeModel(
      otp: json['otp'] ?? '',
      otp_token: json['otp_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'otp': otp, 'otp_token': otp_token};
  }
}
