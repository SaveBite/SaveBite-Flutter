import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/entity/tracking_product_entity.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/repo/tracking_repo.dart';

class GetTrackingProductsUseCase {
  final TrackingRepo trackingRepo;

  GetTrackingProductsUseCase({required this.trackingRepo});

  Future<Either<Failure, List<TrackingProductEntity>>> call() {
    return trackingRepo.getAllTrackingProducts();
  }
}
