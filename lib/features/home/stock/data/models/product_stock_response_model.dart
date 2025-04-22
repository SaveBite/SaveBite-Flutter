import 'package:save_bite/features/home/stock/domain/entites/product_stock_response_entity.dart';

class ProductStockResponseModel extends ProductStockResponseEntity {
  const ProductStockResponseModel({
    required DateTime startDate,
    required DateTime endDate,
    required List<DatumModel> data,
  }) : super(
    startDate: startDate,
    endDate: endDate,
    data: data,
  );

  factory ProductStockResponseModel.fromJson(Map<String, dynamic> json) {
    final responseData = json['data'];  //  Extract the nested data object
    return ProductStockResponseModel(
      startDate: DateTime.parse(responseData['start_date']),
      endDate: DateTime.parse(responseData['end_date']),
      data: (responseData['data'] as List<dynamic>)  //  Ensures it's a List before mapping
          .map((item) => DatumModel.fromJson(item))
          .toList(),
    );
  }

  ///  Convert Model to JSON (useful for caching or sending data)
  Map<String, dynamic> toJson() {
    return {
      'data': {
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
        'data': data.map((x) => x.toJson()).toList(),
      },
    };
  }
}

class DatumModel extends DatumEntity {
  const DatumModel({
    required String productName,
    required String category,
    required List<int> reorderQuantities,
  }) : super(
    productName: productName,
    category: category,
    reorderQuantities: reorderQuantities,
  );

  factory DatumModel.fromJson(Map<String, dynamic> json) {
    return DatumModel(
      productName: json['ProductName'],
      category: json['Category'],
      reorderQuantities: List<int>.from(json['ReorderQuantities']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProductName': productName,
      'Category': category,
      'ReorderQuantities': reorderQuantities,
    };
  }
}
