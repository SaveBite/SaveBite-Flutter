import 'package:dartz/dartz.dart';
import 'package:save_bite/features/authentication/sign_up/domain/entities/auth_entity.dart';
import 'package:save_bite/features/authentication/verification/domain/entity/check_code_response_entity.dart';
import 'package:save_bite/features/authentication/verification/domain/repo/verification_repo.dart';

import '../../../../../core/error/failure.dart';
import '../entity/check_code_entity.dart';


class CheckCodeUseCase {
  final VerificationRepo verificationRepo;

  CheckCodeUseCase({required this.verificationRepo});

  Future<Either<Failure, CheckCodeResponseEntity>> call(CheckCodeEntity checkCodeEntity) async {
    return await verificationRepo.checkCode(checkCodeEntity);
  }

}


