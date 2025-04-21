import 'package:hive/hive.dart';
import 'package:save_bite/constants.dart';
import 'package:save_bite/features/authentication/login/data/model/user_model.dart';

class AuthLocalDataSource {
  static Future<UserModel?> getUser() async {
    var userBox = Hive.box<UserModel?>(kUserBox);
    return userBox.get('user');
  }

  static Future<void> clearUser() async {
    var userBox = Hive.box<UserModel?>(kUserBox);
    await userBox.delete('user');
  }
}
