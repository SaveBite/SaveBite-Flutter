import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/entity/tracking_product_entity.dart';

abstract class TrackingRepo {
  Future<Either<Failure, List<TrackingProductEntity>>> getAllTrackingProducts();
  Future<Either<Failure, Unit>> deleteTrackingProduct(int id);
}
