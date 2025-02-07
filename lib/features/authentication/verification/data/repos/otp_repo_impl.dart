import 'package:dartz/dartz.dart';
import 'package:save_bite/features/authentication/verification/data/datasources/remote_data_source.dart';
import 'package:save_bite/features/authentication/verification/data/models/check_code_model.dart';
import 'package:save_bite/features/authentication/verification/data/models/resend_code_model.dart';
import 'package:save_bite/features/authentication/verification/domain/entity/check_code_entity.dart';
import 'package:save_bite/features/authentication/verification/domain/entity/check_code_response_entity.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/local_data_source.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/entity/resend_code response_entity.dart';
import '../../domain/entity/resend_code_entity.dart';
import '../../domain/repo/verification_repo.dart';

class OtpRepoImpl implements VerificationRepo {
  final NetworkInfo networkInfo;
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;


  OtpRepoImpl({required this.networkInfo,required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, CheckCodeResponseEntity>> checkCode(
      CheckCodeEntity checkCodeEntity) async {
    try {
      final CheckCodeModel checkCodeModel = CheckCodeModel(
          otp: checkCodeEntity.otp, otp_token: checkCodeEntity.otp_token);
      print("📤 Sending OTP verification request with: ${checkCodeModel.toJson()}");
      final result = await remoteDataSource.checkCode(checkCodeModel);
      print("✅ OTP verification successful! Response: ${result.token}");
      return Right(result);
    } on ServerException catch (e) {
      print("❌ OTP verification failed: ${e}");
      return Left(ServerFailure(message: e.message));
    }
  }


  @override
  Future<Either<Failure, ResendCodeResponseEntity>> resendOtp(ResendCodeEntity resendCodeEntity) async{
    try {
      final ResendCodeModel resendCodeModel = ResendCodeModel(email: resendCodeEntity.email);
      print("📤 Sending OTP verification request with: ${resendCodeModel.toJson()}");
      final result = await remoteDataSource.resendOtp(resendCodeModel);
      print("✅ OTP verification successful! Response: ${result}");
      localDataSource.cacheToken(result.otpToken);
      return Right(result);
    } on ServerException catch (e) {
      print("❌ OTP verification failed: ${e}");
      return Left(ServerFailure(message: e.message));
    }
  }


}


