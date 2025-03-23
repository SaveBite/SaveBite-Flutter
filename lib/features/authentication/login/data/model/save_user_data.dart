import 'package:save_bite/features/authentication/login/data/model/user_model.dart';

class SaveUserData {
  static UserModel? _user;
  static bool? _rememberMe;

  static UserModel? get user => _user;
  static bool? get rememberMe => _rememberMe;

  static void setUser(UserModel userModel) {
    _user = userModel;
  }

  static void clearUser() {
    _user = null;
  }

  static void setRememberMe(bool rememberMe) {
    _rememberMe = rememberMe;
  }

  static void clearRememberMe() {
    _rememberMe = null;
  }
}
