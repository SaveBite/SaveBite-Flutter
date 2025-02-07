import 'package:dartz/dartz.dart';
import 'package:save_bite/features/authentication/sign_up/domain/entities/auth_entity.dart';
import '../../../../../core/error/failure.dart';
import '../entities/sign_up_entity.dart';
import '../repos/auth_repo.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<Either<Failure, AuthEntity>> call(SignUpEntity signUpEntity) async {
    return await authRepository.signUp(signUpEntity);
  }

}


