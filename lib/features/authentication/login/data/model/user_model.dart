import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String? otpToken;
  @HiveField(3)
  final String type;
  @HiveField(4)
  final num isVerified;
  @HiveField(5)
  final String token;

  UserModel({
    required this.name,
    required this.email,
    required this.otpToken,
    required this.type,
    required this.isVerified,
    required this.token,
  });

  factory UserModel.fromJson(jsonData) {
    return UserModel(
      name: jsonData['data']['name'],
      email: jsonData['data']['email'],
      otpToken: jsonData['data']['otp_token'],
      type: jsonData['data']['type'],
      isVerified: jsonData['data']['is_verified'],
      token: jsonData['data']['token'],
    );
  }
}
