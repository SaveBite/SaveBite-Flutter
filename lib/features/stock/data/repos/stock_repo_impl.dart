import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_bite/core/failure/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entites/product_filter_entity.dart';
import '../../domain/entites/product_stock_response_entity.dart';
import '../../domain/repos/stock_repo.dart';
import '../datasources/stock_remote_data_source.dart';

class StockRepoImp extends StockRepo {
  final StockRemoteDataSource stockRemoteDataSource;
  final NetworkInfo networkInfo;

  StockRepoImp({
    required this.stockRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProductStockResponseEntity>> stockProducts(ProductFilterEntity filter) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteStock = await stockRemoteDataSource.stockProducts(filter);
        return right(remoteStock);
      } on DioException catch (e) {
        print("❌ DioException occurred");
        print("Message: ${e.message}");
        print("Status Code: ${e.response?.statusCode}");
        print("Response Data: ${e.response?.data}");
        return left(ServerFailure.fromDioException(e));
      } catch (e) {
        print("❌ Unexpected error: $e");
        return left(ServerFailure(errorMessage: "Unexpected error: ${e.toString()}"));
      }
    } else {
      print("❌ No Internet Connection");
      return left(ServerFailure(errorMessage: "No Internet Connection"));
    }
  }
}
