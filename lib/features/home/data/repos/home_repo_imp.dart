import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/home/data/date_sources/home_remote_data_sources.dart';
import 'package:save_bite/features/home/data/models/product_model.dart';
import 'package:save_bite/features/home/data/models/stock_data_model.dart';
import 'package:save_bite/features/home/domain/repos/home_repo.dart';

class HomeRepoImp extends HomeRepo {
  final HomeRemoteDataSources homeRemoteDataSources;

  HomeRepoImp({required this.homeRemoteDataSources});
  @override
  Future<Either<Failure, List<ProductModel>>> getProducts(
      {String? productName, String? sortBy}) async {
    try {
      List<ProductModel> products = await homeRemoteDataSources.getProducts(
        productName: productName,
        sortBy: sortBy,
      );
      return right(products);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StockDataModel>> getStockData() async {
    try {
      StockDataModel stockData = await homeRemoteDataSources.getStockData();
      return right(stockData);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProducts(
      {required File productsFile}) async {
    try {
      String message = await homeRemoteDataSources.uploadProducrs(
          productsFile: productsFile);
      return right(message);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
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
  }) async {
    try {
      ProductModel products = await homeRemoteDataSources.addProduct(
        date: date,
        productName: productName,
        category: category,
        unitPrice: unitPrice,
        stockQuantity: stockQuantity,
        reorderLevel: reorderLevel,
        reorderQuantity: reorderQuantity,
        unitsSold: unitsSold,
        salesValue: salesValue,
        month: month,
      );
      return right(products);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
