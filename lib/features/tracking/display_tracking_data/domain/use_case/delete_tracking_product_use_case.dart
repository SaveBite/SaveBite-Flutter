import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/repo/tracking_repo.dart';

class DeleteTrackingProductUseCase {
  final TrackingRepo repo;

  DeleteTrackingProductUseCase({required this.repo});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repo.deleteTrackingProduct(id);
  }
}
