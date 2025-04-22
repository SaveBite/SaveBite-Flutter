import 'package:equatable/equatable.dart';

class ProductStockResponseEntity extends Equatable {
  final DateTime startDate;
  final DateTime endDate;
  final List<DatumEntity> data;

  const ProductStockResponseEntity({
    required this.startDate,
    required this.endDate,
    required this.data,
  });

  @override
  List<Object?> get props => [startDate, endDate, data];
}

class DatumEntity extends Equatable {
  final String productName;
  final String category;
  final List<int> reorderQuantities;

  const DatumEntity({
    required this.productName,
    required this.category,
    required this.reorderQuantities,
  });

  @override
  List<Object?> get props => [productName, category, reorderQuantities];

  // Add the toJson method
  Map<String, dynamic> toJson() {
    return {
      'ProductName': productName,
      'Category': category,
      'ReorderQuantities': reorderQuantities,
    };
  }
}
