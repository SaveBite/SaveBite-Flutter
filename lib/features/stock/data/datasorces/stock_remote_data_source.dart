import 'package:dio/dio.dart';
import 'package:save_bite/constants.dart';
import 'package:save_bite/features/stock/data/models/product_filter_model.dart';
import '../../../../core/network/auth_local_data_source.dart';
import '../../domain/entites/product_filter_entity.dart';
import '../../domain/entites/product_stock_response_entity.dart';
import '../models/product_stock_response_model.dart';

abstract class StockRemoteDataSource {
  Future<ProductStockResponseEntity> stockProducts(ProductFilterEntity filter);
}

// ✅ API Base URL
const String BASE_URL = kBaseUrl;

class StockRemoteDataSourceImp extends StockRemoteDataSource {
  final Dio dio;

  StockRemoteDataSourceImp({required this.dio});

  @override
  Future<ProductStockResponseEntity> stockProducts(
      ProductFilterEntity filter) async {
    final user = await AuthLocalDataSource.getUser();
    final token = user?.token;

    try {
      final queryParams =
          ProductFilterModel(search: filter.search, category: filter.category)
              .toQueryParameters();

      final response = await dio.get("$BASE_URL/stock",
          queryParameters: queryParams,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
          ));

      print("📡 API RESPONSE: ${response.data}");

      // Parse response into ProductStockResponseModel
      return ProductStockResponseModel.fromJson(response.data);
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: "/stock"),
        error: "Failed to fetch stock data",
      );
    }
  }
}
