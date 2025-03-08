import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/authentication/login/data/model/user_model.dart';
import 'package:save_bite/features/authentication/login/domain/repo/login_repo.dart';

class LoginEmailPasswordUseCase {
  final LoginRepo loginRepo;

  LoginEmailPasswordUseCase({required this.loginRepo});
  Future<Either<Failure, UserModel>> call({
    required String email,
    required String password,
  }) {
    return loginRepo.loginEmailPassword(
      email: email,
      password: password,
    );
  }
}
