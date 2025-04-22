import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import '../entites/product_filter_entity.dart';
import '../entites/product_stock_response_entity.dart';
import '../repos/stock_repo.dart';

class StockUseCase {
  final StockRepo stockRepo;

  StockUseCase({required this.stockRepo});

  Future<Either<Failure, ProductStockResponseEntity>> call(ProductFilterEntity filter) async {
    return await stockRepo.stockProducts(filter);
  }
}
