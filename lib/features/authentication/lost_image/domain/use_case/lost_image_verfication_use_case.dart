import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/authentication/lost_image/domain/repo/lost_image_repo.dart';

class LostImageVerficationUseCase {
  final LostImageRepo lostImageRepo;

  LostImageVerficationUseCase({required this.lostImageRepo});
  Future<Either<Failure, String>> call({
    required String email,
    required String otp,
    required String otpToken,
  }) {
    return lostImageRepo.lostImageVerfication(
      email: email,
      otp: otp,
      otpToken: otpToken,
    );
  }
}
