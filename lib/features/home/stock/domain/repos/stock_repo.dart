import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import '../entites/product_filter_entity.dart';
import '../entites/product_stock_response_entity.dart';

abstract class StockRepo {
  Future<Either<Failure, ProductStockResponseEntity>> stockProducts(ProductFilterEntity filter);
}
