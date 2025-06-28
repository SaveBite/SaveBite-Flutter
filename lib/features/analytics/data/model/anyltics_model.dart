class AnalyticsModel {
  int stockTurnoverRate;
  double stockTurnoverRateChange;
  int reorderAccuracyRate;
  double reorderAccuracyRateChange;
  Map<String, int> categoryOverstocking;
  Map<String, double> categoryOverstockingChange;
  int revenue;
  double revenueChange;

  AnalyticsModel({
    required this.stockTurnoverRate,
    required this.stockTurnoverRateChange,
    required this.reorderAccuracyRate,
    required this.reorderAccuracyRateChange,
    required this.categoryOverstocking,
    required this.categoryOverstockingChange,
    required this.revenue,
    required this.revenueChange,
  });

  factory AnalyticsModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsModel(
      stockTurnoverRate:
          (double.parse(json['stock_turnover_rate'] as String) * 100).round(),
      stockTurnoverRateChange:
          (double.tryParse(json['stock_turnover_rate_change'].toString()) ??
                  0.0) /
              100.0,
      reorderAccuracyRate:
          (double.parse(json['reorder_accuracy_rate'] as String) * 100).round(),
      reorderAccuracyRateChange:
          (double.tryParse(json['reorder_accuracy_rate_change'].toString()) ??
                  0.0) /
              100.0,
      categoryOverstocking:
          (json['category_overstocking'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, int.parse(value.toString())),
      ),
      categoryOverstockingChange:
          (json['category_overstocking_change'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, double.parse(value.toString()) / 100.0),
      ),
      revenue: (double.parse(json['revenue'] as String)).round(),
      revenueChange:
          (double.tryParse(json['revenue_change'].toString()) ?? 0.0) / 100.0,
    );
  }

  // Optional: Method to convert the model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'stock_turnover_rate': stockTurnoverRate,
      'stock_turnover_rate_change': stockTurnoverRateChange,
      'reorder_accuracy_rate': reorderAccuracyRate,
      'reorder_accuracy_rate_change': reorderAccuracyRateChange,
      'category_overstocking': categoryOverstocking,
      'category_overstocking_change': categoryOverstockingChange,
      'revenue': revenue,
      'revenue_change': revenueChange,
    };
  }

  // Helper methods to get lists from the maps
  List<String> get categoryOverstockingProducts =>
      categoryOverstocking.keys.toList();
  List<int> get categoryOverstockingValues =>
      categoryOverstocking.values.toList();
  List<double> get categoryOverstockingChangeValues =>
      categoryOverstockingChange.values.toList();
}
