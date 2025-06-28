import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/analytics/data/model/anyltics_model.dart';
import 'package:save_bite/features/analytics/domain/entity/sales_data_entity.dart';

abstract class AnaylticsRepo {
  Future<Either<Failure, AnalyticsModel>> fetchAnaylticsDetails();
  Future<Either<Failure, SalesDataEntity>> getSalesData();
}
