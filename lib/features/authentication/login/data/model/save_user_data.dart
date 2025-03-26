import 'package:save_bite/features/authentication/login/data/model/user_model.dart';

abstract class SaveUserData {
  static UserModel? user;
  static bool? rememberMe;
}
