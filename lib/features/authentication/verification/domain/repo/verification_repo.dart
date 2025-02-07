import 'package:dartz/dartz.dart';
import 'package:save_bite/features/authentication/verification/domain/entity/check_code_response_entity.dart';
import 'package:save_bite/features/authentication/verification/domain/entity/resend_code%20response_entity.dart';
import '../../../../../core/error/failure.dart';
import '../entity/check_code_entity.dart';
import '../entity/resend_code_entity.dart';

abstract class VerificationRepo {
  Future<Either<Failure, CheckCodeResponseEntity>>  checkCode(CheckCodeEntity checkCodeEntity);
  Future<Either<Failure, ResendCodeResponseEntity>> resendOtp(ResendCodeEntity resendCodeEntity);

}