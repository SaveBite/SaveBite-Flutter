import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/analytics/domain/entity/sales_data_entity.dart';
import 'package:save_bite/features/analytics/domain/repos/anayltics_repo.dart';

class GetSalesDataUseCase {
  final AnaylticsRepo anaylticsRepo;

  GetSalesDataUseCase({required this.anaylticsRepo});
  Future<Either<Failure, SalesDataEntity>> call() {
    return anaylticsRepo.getSalesData();
  }
}
