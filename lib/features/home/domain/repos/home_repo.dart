import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/home/data/models/product_model.dart';
import 'package:save_bite/features/home/data/models/stock_data_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ProductModel>>> getProducts(
      {String? productName, String? sortBy});
  Future<Either<Failure, StockDataModel>> getStockData();
  Future<Either<Failure, String>> uploadProducts({required File productsFile});
  Future<Either<Failure, ProductModel>> addProduct({
    required String date,
    required String productName,
    required String category,
    required String unitPrice,
    required String stockQuantity,
    required String reorderLevel,
    required String reorderQuantity,
    required String unitsSold,
    required String salesValue,
    required String month,
  });
}
