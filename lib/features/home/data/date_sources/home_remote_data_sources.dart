import 'dart:io';

import 'package:dio/dio.dart';
import 'package:save_bite/constants.dart';
import 'package:save_bite/features/authentication/login/data/model/save_user_data.dart';
import 'package:save_bite/features/home/data/models/product_model.dart';
import 'package:save_bite/features/home/data/models/stock_data_model.dart';

abstract class HomeRemoteDataSources {
  Future<List<ProductModel>> getProducts({String? productName, String? sortBy});
  Future<StockDataModel> getStockData();
  Future<String> uploadProducrs({required File productsFile});
  Future<ProductModel> addProduct({
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

class HomeRemoteDataSourcesImp extends HomeRemoteDataSources {
  final Dio dio;
  final String baseUrl = kBaseUrl;

  HomeRemoteDataSourcesImp({required this.dio});
  @override
  Future<List<ProductModel>> getProducts(
      {String? productName, String? sortBy}) async {
    if (productName != null) {
      Response response = await dio.get(
        '$baseUrl/products?search=$productName',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${SaveUserData.user!.token}',
          },
        ),
      );
      List<dynamic> itemsList = response.data["data"]["Products"];
      List<ProductModel> products = [];
      for (var iteam in itemsList) {
        products.add(ProductModel.fromJson(iteam));
      }
      return products;
    } else if (sortBy != null) {
      Response response = await dio.get(
        '$baseUrl/products?status=$sortBy',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${SaveUserData.user!.token}',
          },
        ),
      );
      List<dynamic> itemsList = response.data["data"]["Products"];
      List<ProductModel> products = [];
      for (var iteam in itemsList) {
        products.add(ProductModel.fromJson(iteam));
      }
      return products;
    } else if (productName != null && sortBy != null) {
      Response response = await dio.get(
        '$baseUrl/products?search=$productName&status=$sortBy',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${SaveUserData.user!.token}',
          },
        ),
      );
      List<dynamic> itemsList = response.data["data"]["Products"];
      List<ProductModel> products = [];
      for (var iteam in itemsList) {
        products.add(ProductModel.fromJson(iteam));
      }
      return products;
    } else {
      Response response = await dio.get(
        '$baseUrl/products',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${SaveUserData.user!.token}',
          },
        ),
      );
      List<dynamic> itemsList = response.data["data"]["Products"];
      List<ProductModel> products = [];
      for (var iteam in itemsList) {
        products.add(ProductModel.fromJson(iteam));
      }
      return products;
    }
  }

  @override
  Future<StockDataModel> getStockData() async {
    Response response = await dio.get(
      '$baseUrl/products',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${SaveUserData.user!.token}',
        },
      ),
    );

    StockDataModel stockData = StockDataModel.fromJson(response.data["data"]);
    return stockData;
  }

  @override
  Future<String> uploadProducrs({required File productsFile}) async {
    String fileName = productsFile.path.split('/').last;

    FormData formData = FormData.fromMap({
      "csv_file": await MultipartFile.fromFile(
        productsFile.path,
        filename: fileName,
      ),
    });

    Response response = await dio.post(
      "$baseUrl/products/upload",
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${SaveUserData.user!.token}',
        },
      ),
    );
    String message = response.data["message"];
    if (message == "File Uploaded Successfully") {
      return message;
    } else {
      return (response.data["data"][0]);
    }
  }

  @override
  Future<ProductModel> addProduct({
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
    Response response = await dio.post(
      '$baseUrl/products/',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${SaveUserData.user!.token}',
        },
      ),
      data: {
        "Date": date,
        "ProductName": productName,
        "Category": category,
        "UnitPrice": unitPrice,
        "StockQuantity": stockQuantity,
        "ReorderLevel": reorderLevel,
        "ReorderQuantity": reorderQuantity,
        "UnitsSold": unitsSold,
        "SalesValue": salesValue,
        "Month": month,
      },
    );
    ProductModel product = ProductModel.fromJson(response.data["data"]);
    return product;
  }
}
