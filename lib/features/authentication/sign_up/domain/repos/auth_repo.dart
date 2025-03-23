import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:save_bite/features/authentication/sign_up/domain/entities/auth_entity.dart';

import '../../../../../core/error/failure.dart';
import '../entities/sign_up_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> signUp(SignUpEntity signUpEntity);
}
