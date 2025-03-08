import 'package:hive_flutter/hive_flutter.dart';
import 'package:save_bite/constants.dart';
import 'package:save_bite/features/authentication/login/data/model/user_model.dart';

Future<void> intialHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel?>(kUserBox);
    await Hive.openBox<bool?>(kRemmberBox);
}