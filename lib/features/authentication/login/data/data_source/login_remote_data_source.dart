import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:save_bite/constants.dart';
import 'package:save_bite/features/authentication/login/data/model/user_model.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> loginEmailImage(
      {required String email, required File image});
  Future<UserModel> loginEmailPassword(
      {required String email, required String password});
}

class LoginRemoteDataSourceImp extends LoginRemoteDataSource {
  final baseUrl = kBaseUrl;
  @override
  Future<UserModel> loginEmailImage(
      {required String email, required File image}) async {
    var dio = Dio();
    var formData = FormData.fromMap({
      'email': email,
      'image': await MultipartFile.fromFile(image.path,
          filename: image.path.split('/').last, // استخلاص اسم الملف من مساره
          contentType: MediaType('image', 'jpeg')), // تحديد نوع الملف
    });

    var response = await dio.post(
      '$baseUrl/auth/sign/in',
      data: formData,
      onSendProgress: (int sent, int total) {},
    );
    Map<String, dynamic> userInfo = response.data; // Access data directly
    UserModel userModel = UserModel.fromJson(userInfo);

    return (userModel);
  }

  @override
  Future<UserModel> loginEmailPassword(
      {required String email, required String password}) async {
    var dio = Dio();
    var response = await dio.post(
      '$baseUrl/auth/sign/in',
      data: {
        'email': email,
        'password': password,
      },
    );

    Map<String, dynamic> userInfo = response.data; // Access data directly
    UserModel userModel = UserModel.fromJson(userInfo);

    return (userModel);
  }
}
