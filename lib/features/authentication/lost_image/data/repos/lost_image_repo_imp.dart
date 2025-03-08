import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/authentication/lost_image/data/data_sources/lost_image_remote_data_source.dart';
import 'package:save_bite/features/authentication/lost_image/domain/repo/lost_image_repo.dart';

class LostImageRepoImp extends LostImageRepo {
  final LostImageRemoteDataSource lostImageRemoteDataSource;

  LostImageRepoImp({required this.lostImageRemoteDataSource});
  @override
  Future<Either<Failure, String>> lostImage(
      {required String email, required String answer}) async {
    try {
      String otpToken = await lostImageRemoteDataSource.lostImage(
        email: email,
        answer: answer,
      );
      return right(otpToken);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(
          ServerFailure(errorMessage: e.toString()),
        );
      }
    }
  }

  @override
  Future<Either<Failure, String>> lostImageVerfication(
      {required String email,
      required String otp,
      required String otpToken}) async {
    try {
      await lostImageRemoteDataSource.lostImageVerfication(
          email: email, otp: otp, otptoken: otpToken);
      return right('success');
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(
          ServerFailure(errorMessage: e.toString()),
        );
      }
    }
  }
}
