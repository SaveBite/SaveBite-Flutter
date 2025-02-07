import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:save_bite/core/strings/constant.dart';
import 'package:save_bite/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/authentication/sign_up/data/models/auth_model.dart';

abstract class LocalDataSource {
  Future<Unit> cacheToken(String token);
  Future<String> getToken();
  Future<Unit> cacheLoggedInUserInfo(AuthModel authModel);
  Future<AuthModel> getLoggedInUser();
  Future<Unit> removeLoggedInUser();
  Future<Unit> removeToken();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  /// ✅ Store authentication token
  @override
  Future<Unit> cacheToken(String token) async {
    await sharedPreferences.setString(LocalStorage.TOKEN, token);
    return Future.value(unit);
  }

  /// ✅ Retrieve token from storage
  @override
  Future<String> getToken() async {
    final token = sharedPreferences.getString(LocalStorage.TOKEN);
    if (token != null && token.isNotEmpty) {
      return token;
    } else {
      throw CacheFailure(message: "❌ Token not found in local storage");
    }
  }

  /// ✅ Remove token from storage (used in logout)
  @override
  Future<Unit> removeToken() async {
    await sharedPreferences.remove(LocalStorage.TOKEN);
    return unit;
  }

  /// ✅ Store logged-in user info as JSON
  @override
  Future<Unit> cacheLoggedInUserInfo(AuthModel authModel) async {
    final userJson = jsonEncode(authModel.toJson());
    await sharedPreferences.setString(LocalStorage.AUTH_USER_INFO, userJson);
    return unit;
  }

  /// ✅ Retrieve logged-in user from storage
  @override
  Future<AuthModel> getLoggedInUser() async {
    final userJson = sharedPreferences.getString(LocalStorage.AUTH_USER_INFO);
    if (userJson != null && userJson.isNotEmpty) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      return AuthModel.fromJson(userMap);
    } else {
      throw CacheFailure(message: "❌ User info not found in local storage");
    }
  }

  /// ✅ Remove logged-in user info from storage (used in logout)
  @override
  Future<Unit> removeLoggedInUser() async {
    await sharedPreferences.remove(LocalStorage.AUTH_USER_INFO);
    return unit;
  }
}
