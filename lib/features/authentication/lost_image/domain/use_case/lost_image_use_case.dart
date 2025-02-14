import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/authentication/lost_image/domain/repo/lost_image_repo.dart';

class LostImageUseCase {
  final LostImageRepo lostImageRepo;

  LostImageUseCase({required this.lostImageRepo});
  Future<Either<Failure, String>> call({
    required String email,
    required String answer,
  }) {
    return lostImageRepo.lostImage(
      email: email,
      answer: answer,
    );
  }
}
