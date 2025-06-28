import 'package:dio/dio.dart';
import 'package:save_bite/constants.dart';

abstract class LostImageRemoteDataSource {
  Future<String> lostImage({
    required String email,
    required String answer,
  });
  Future<String> lostImageVerfication({
    required String email,
    required String otp,
    required String otptoken,
  });
}

class LostImageRemoteDataSourceImp extends LostImageRemoteDataSource {
  final String baseUrl = kBaseUrl;
  @override
  Future<String> lostImage(
      {required String email, required String answer}) async {
    var dio = Dio();
    var response = await dio.post(
      '$baseUrl/lost-image',
      data: {
        'email': email,
        'answer': answer,
      },
    );

    Map<String, dynamic> userInfo = response.data;
    String otpToken = userInfo['data']['otp_token'];
    return otpToken;
  }

  @override
  Future<String> lostImageVerfication(
      {required String email,
      required String otp,
      required String otptoken}) async {
    var dio = Dio();
    var response = await dio.post(
      '$baseUrl/lost-image-check-code',
      data: {
        'email': email,
        'otp': otp,
        'otp_token': otptoken,
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Accept-Language': 'en',
        },
      ),
    );
    Map<String, dynamic> userInfo = response.data;

    String message = userInfo['message'];

    return message;
  }
}
