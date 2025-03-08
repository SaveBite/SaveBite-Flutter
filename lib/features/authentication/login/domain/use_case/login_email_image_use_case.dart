import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/authentication/login/data/model/user_model.dart';
import 'package:save_bite/features/authentication/login/domain/repo/login_repo.dart';

class LoginEmailImageUseCase {
  final LoginRepo loginRepo;

  LoginEmailImageUseCase({required this.loginRepo});
  Future<Either<Failure, UserModel>> call({
    required String email,
    required File image,
  }) {
    return loginRepo.loginEmailImage(
      email: email,
      image: image,
    );
  }
}
