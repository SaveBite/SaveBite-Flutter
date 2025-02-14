import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/authentication/login/data/model/user_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, UserModel>> loginEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserModel>> loginEmailImage({
    required String email,
    required File image,
  });
}
