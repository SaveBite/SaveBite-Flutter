import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:save_bite/features/stock/data/models/product_filter_model.dart';
import '../../../../core/network/auth_local_data_source.dart';
import '../../domain/entites/product_filter_entity.dart';
import '../../domain/entites/product_stock_response_entity.dart';
import '../models/product_stock_response_model.dart';

abstract class StockRemoteDataSource {
  Future<ProductStockResponseEntity> stockProducts(ProductFilterEntity filter);
}

const String BASE_URL = "https://save-bite.ghonim.makkah.solutions/api/v1/mobile";

class StockRemoteDataSourceImp extends StockRemoteDataSource {
  final Dio dio;

  StockRemoteDataSourceImp({required this.dio});

  @override
  Future<ProductStockResponseEntity> stockProducts(ProductFilterEntity filter) async {
    final user = await AuthLocalDataSource.getUser();
    final token = user?.token;

    final queryParams = ProductFilterModel(
      search: filter.search,
      category: filter.category,
    ).toQueryParameters();

    try {
      print('📥 Sending Stock API request with token: $token and filter: ${jsonEncode(queryParams)}');

      final response = await dio.get(
        "$BASE_URL/stock",
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': '*/*',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
            'User-Agent': 'PostmanRuntime/7.44.1',
          },
        ),
      );

      print("📡 API RESPONSE: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data['data'];
        if (data == null ||
            data['start_date'] == null ||
            data['end_date'] == null ||
            data['data'] == null ||
            data['data'] is! List) {
          throw Exception("Invalid or incomplete stock response data");
        }
        return ProductStockResponseModel.fromJson(response.data);
      } else {
        throw DioException(
          response: response,
          requestOptions: response.requestOptions,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      print("❌ DioException occurred");
      print("Message: ${e.message}");
      print("Status Code: ${e.response?.statusCode}");
      print("Response Data: ${e.response?.data}");
      throw e;
    } catch (e) {
      print("❌ Unexpected error: $e");
      throw DioException(
        requestOptions: RequestOptions(path: "/stock"),
        error: "Unexpected stock parsing error: ${e.toString()}",
        type: DioExceptionType.unknown,
      );
    }
  }
}
