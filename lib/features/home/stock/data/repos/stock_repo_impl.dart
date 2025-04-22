import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_bite/core/failure/failure.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/entites/product_filter_entity.dart';
import '../../domain/entites/product_stock_response_entity.dart';
import '../../domain/repos/stock_repo.dart';
import '../datasorces/stock_remote_data_source.dart';

class StockRepoImp extends StockRepo {
  final StockRemoteDataSource stockRemoteDataSource;
  final NetworkInfo networkInfo;

  StockRepoImp({required this.stockRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, ProductStockResponseEntity>> stockProducts(ProductFilterEntity filter) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteStock = await stockRemoteDataSource.stockProducts(filter);

        return right(remoteStock);
      } catch (e) {
        if (e is DioException) {
          return left(ServerFailure.fromDioException(e));
        } else {
          return left(ServerFailure(errorMessage: e.toString()));
        }
      }
    } else {
      return left(ServerFailure(errorMessage: "No Internet Connection"));
    }
  }
}
