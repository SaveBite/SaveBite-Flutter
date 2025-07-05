import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:save_bite/features/authentication/verification/data/models/check_code_response_model.dart';
import 'package:save_bite/features/authentication/verification/domain/entity/check_code_response_entity.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../sign_up/data/datasorces/remote_data_source.dart';
import '../../domain/entity/resend_code response_entity.dart';
import '../models/check_code_model.dart';
import '../models/resend_code_model.dart';
import '../models/resend_code_response_model.dart';

abstract class RemoteDataSource {
  Future<CheckCodeResponseEntity> checkCode(CheckCodeModel checkCodeModel);
  Future<ResendCodeResponseEntity> resendOtp(ResendCodeModel resendCodeModel);
}

// ✅ API Base URL
const String BASE_URL =
    "https://save-bite.ghonim.makkah.solutions/api/v1/mobile";

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  String? _cachedOtpToken;
  final AuthRemoteDataSource authDataSource; // ✅ Use interface

  RemoteDataSourceImpl({
    required this.client,
    required this.authDataSource, // ✅ Fix type
  });

  /// ✅ Stores the latest OTP token
  void _cacheOtpToken(String token) {
    _cachedOtpToken = token;
    print("🛠️ Cached OTP Token: $_cachedOtpToken");
  }

  /// 🔹 Retrieves the latest OTP token (fallback if missing)
  String? _getOtpToken(String? providedToken) {
    return providedToken?.isNotEmpty == true ? providedToken : _cachedOtpToken;
  }

  @override
  Future<CheckCodeResponseEntity> checkCode(
      CheckCodeModel checkCodeModel) async {
    try {
      var uri = Uri.parse('$BASE_URL/otp/verify');

      // ✅ Get token from input or fallback to cached token
      String? token = _getOtpToken(checkCodeModel.otp_token);
      if (token == null) {
        throw Exception("❌ No OTP Token available. Please request a new code.");
      }

      // ✅ Get token from sign-up, NOT the OTP token
      String? authToken = authDataSource.authToken;
      if (authToken == null) {
        throw Exception("❌ No authentication token available.");
      }

      final body = {
        "otp": checkCodeModel.otp,
        "otp_token": token, // ✅ Use the latest available token
      };

      final response = await client.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'Accept-Language': 'en',
          'Authorization': 'Bearer $authToken',
        },
        body: body,
      );

      print("📤 Sending OTP verification request: $body");
      print("📩 Response: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ Verification successful!");
        final responseBody = jsonDecode(response.body);
        return CheckCodeResponseModel.fromJson(responseBody['data']);
      } else {
        print("❌ Verification failed. Response: ${response.body}");
        final error = jsonDecode(response.body)['message'] ?? 'Unknown error';
        throw ServerException(error);
      }
    } catch (e) {
      print("🚨 Exception in verification: $e");
      throw ServerException("Failed to verify OTP. Please try again later.");
    }
  }

  @override
  Future<ResendCodeResponseEntity> resendOtp(
      ResendCodeModel resendCodeModel) async {
    try {
      final uri = Uri.parse('$BASE_URL/otp?email=${resendCodeModel.email}');

      final response = await client.get(uri, headers: {
        'Accept': 'application/json',
        'Accept-Language': 'ar',
      });

      print("📤 Sending Resend OTP request...");
      print("📩 Response: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ OTP resent successfully!");

        final responseBody = jsonDecode(response.body);

        if (responseBody['status'] == 200) {
          final newToken = responseBody['data']['otp_token'];
          if (newToken != null) {
            _cacheOtpToken(newToken);
          }

          return ResendCodeResponseModel.fromJson(responseBody);
        } else {
          final errorMessage = responseBody['message'] ?? 'Unknown error';
          throw ServerException(errorMessage);
        }
      } else {
        final errorMessage =
            jsonDecode(response.body)['message'] ?? 'Unknown error';
        throw ServerException(errorMessage);
      }
    } catch (e) {
      print("🚨 Exception in OTP resend: $e");
      throw ServerException("Failed to resend OTP. Please try again later.");
    }
  }
}
