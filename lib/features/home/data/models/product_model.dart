class ProductModel {
  String date;
  String productName;
  String category;
  String unitPrice;
  int stockQuantity;
  int reorderLevel;
  int reorderQuantity;
  int unitsSold;
  String salesValue;

  ProductModel({
    required this.date,
    required this.productName,
    required this.category,
    required this.unitPrice,
    required this.stockQuantity,
    required this.reorderLevel,
    required this.reorderQuantity,
    required this.unitsSold,
    required this.salesValue,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        date: json['Date'] as String,
        productName: json['ProductName'] as String,
        category: json['Category'] as String,
        unitPrice: json['UnitPrice'] as String,
        stockQuantity: json['StockQuantity'] as int,
        reorderLevel: json['ReorderLevel'] as int,
        reorderQuantity: json['ReorderQuantity'] as int,
        unitsSold: json['UnitsSold'] as int,
        salesValue: json['SalesValue'] as String,
      );

  Map<String, dynamic> toJson() => {
        'Date': date,
        'ProductName': productName,
        'Category': category,
        'UnitPrice': unitPrice,
        'StockQuantity': stockQuantity,
        'ReorderLevel': reorderLevel,
        'ReorderQuantity': reorderQuantity,
        'UnitsSold': unitsSold,
        'SalesValue': salesValue,
      };
}
