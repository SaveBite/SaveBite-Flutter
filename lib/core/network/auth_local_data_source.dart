import 'package:save_bite/features/authentication/login/data/model/save_user_data.dart';
import 'package:save_bite/features/authentication/login/data/model/user_model.dart';

class AuthLocalDataSource {
  static Future<UserModel?> getUser() async {
    return SaveUserData.user;
  }

  static Future<void> clearUser() async {
    SaveUserData.user = null;
  }
}
