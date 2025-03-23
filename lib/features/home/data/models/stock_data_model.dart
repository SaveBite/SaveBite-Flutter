class StockDataModel {
  final String stockOnHand;
  final String positiveStock;
  final String negativeStock;
  final String belowPar;
  final String belowMinimum;

  StockDataModel({
    required this.stockOnHand,
    required this.positiveStock,
    required this.negativeStock,
    required this.belowPar,
    required this.belowMinimum,
  });

  factory StockDataModel.fromJson(Map<String, dynamic> json) {
    return StockDataModel(
      stockOnHand: json["StockOnHand"],
      positiveStock: (json["PositiveStock"]).toString(),
      negativeStock: (json["NegativeStock"]).toString(),
      belowPar: (json["BelowPar"]).toString(),
      belowMinimum: (json["BelowMinimum"]).toString(),
    );
  }
}
