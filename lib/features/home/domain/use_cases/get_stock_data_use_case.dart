import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/home/data/models/stock_data_model.dart';
import 'package:save_bite/features/home/domain/repos/home_repo.dart';

class GetStockDataUseCase {
  final HomeRepo homeRepo;

  GetStockDataUseCase({required this.homeRepo});
  Future<Either<Failure, StockDataModel>> call() {
    return homeRepo.getStockData();
  }
}
