import 'package:save_bite/features/authentication/verification/domain/entity/resend_code_entity.dart';

import '../../domain/entity/resend_code response_entity.dart';

class ResendCodeResponseModel extends ResendCodeResponseEntity {
  ResendCodeResponseModel({required super.otpToken});

  factory ResendCodeResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?; // Safe cast

    final otpToken = data?['otp_token']; // Get OTP token safely

    return ResendCodeResponseModel(
      otpToken: otpToken is String ? otpToken : '', // Ensure it's a String
    );
  }

  Map<String, dynamic> toJson() => {"otp_token": otpToken};
}
