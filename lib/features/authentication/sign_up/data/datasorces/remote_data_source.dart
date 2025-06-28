import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:save_bite/constants.dart';
import '../../../../../core/error/exceptions.dart';
import '../../domain/entities/auth_entity.dart';
import '../models/auth_model.dart';
import '../models/sign_up_model.dart';
import 'package:path/path.dart' as path;

abstract class AuthRemoteDataSource {
  Future<AuthEntity> signUp(SignUpModel signupmodel);
  String? get authToken;
}

const String BASE_URL = kBaseUrl;

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  String? _authToken;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  String? get authToken => _authToken;

  @override
  Future<AuthEntity> signUp(SignUpModel signUpModel) async {
    try {
      var uri = Uri.parse('$BASE_URL/auth/sign/up');
      String formattedPhone = signUpModel.phone.replaceAll(" ", "");

      var request = http.MultipartRequest('POST', uri)
        ..fields['user_name'] = signUpModel.userName
        ..fields['email'] = signUpModel.email
        ..fields['password'] = signUpModel.password
        ..fields['password_confirmation'] = signUpModel.passwordConfirmation
        ..fields['answer'] = signUpModel.answer.toString()
        ..fields['type'] = signUpModel.type
        ..fields['phone'] = formattedPhone
        ..headers.addAll({
          'Accept': 'application/json',
          'Accept-Language': 'en',
          'Authorization': 'Bearer $authToken',
        });

      // Handle image upload
      if (signUpModel.image.isNotEmpty) {
        File imageFile = File(signUpModel.image);
        if (await imageFile.exists()) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'image',
              imageFile.path,
              filename: path.basename(imageFile.path),
            ),
          );
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("📡 API Response Status Code: ${response.statusCode}");
      print("📡 API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final token = responseBody['data']['token'];

        if (token == null || token.toString().isEmpty) {
          throw ServerException("No authentication token received");
        }

        _authToken = token; // ✅ Store the sign-up token
        print("🔑 Stored Auth Token: $_authToken");

        final authModel = AuthModel.fromJson(responseBody['data']);
        return authModel;
      } else {
        final error = jsonDecode(response.body)['message'] ?? 'Unknown error';
        throw ServerException(error);
      }
    } catch (e) {
      print("🚨 Exception in signUp: $e");
      rethrow;
    }
  }
}
