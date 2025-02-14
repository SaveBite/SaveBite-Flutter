import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';

abstract class LostImageRepo {
  Future<Either<Failure, String>> lostImage({
    required String email,
    required String answer,
  });
  Future<Either<Failure,String>> lostImageVerfication({
    required String email,
    required String otp,
    required String otpToken,
  });
}
