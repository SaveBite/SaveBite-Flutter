import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/tracking/display_tracking_data/data/data_source/tracking_remote_data_source.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/entity/tracking_product_entity.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/repo/tracking_repo.dart';

class TrackingRepoImp extends TrackingRepo {
  final TrackingRemoteDataSource trackingRemoteDataSource;

  TrackingRepoImp({required this.trackingRemoteDataSource});
  @override
  Future<Either<Failure, List<TrackingProductEntity>>>
      getAllTrackingProducts() async {
    try {
      List<TrackingProductEntity> trackingProductsList =
          await trackingRemoteDataSource.getAllTrackingProducts();
      return right(trackingProductsList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(errorMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTrackingProduct(int id) async {
    try {
      await trackingRemoteDataSource.deleteTrackingProduct(id);
      return right(unit);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(errorMessage: e.toString()));
      }
    }
  }
}
