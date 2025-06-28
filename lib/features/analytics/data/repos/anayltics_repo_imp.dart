import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/analytics/data/data_sources/anayltics_remote_data_sources.dart';
import 'package:save_bite/features/analytics/data/model/anyltics_model.dart';
import 'package:save_bite/features/analytics/domain/entity/sales_data_entity.dart';
import 'package:save_bite/features/analytics/domain/repos/anayltics_repo.dart';

class AnaylticsRepoImp extends AnaylticsRepo {
  final AnaylticsRemoteDataSources anaylticsRemoteDataSources;

  AnaylticsRepoImp({required this.anaylticsRemoteDataSources});
  @override
  Future<Either<Failure, AnalyticsModel>> fetchAnaylticsDetails() async {
    try {
      AnalyticsModel analyticsModel =
          await anaylticsRemoteDataSources.fetchAnaylticsDetails();
      return right(analyticsModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SalesDataEntity>> getSalesData() async {
    try {
      SalesDataEntity salesDataEntity =
          await anaylticsRemoteDataSources.getSalesData();
      return right(salesDataEntity);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
