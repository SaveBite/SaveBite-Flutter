import 'package:save_bite/features/analytics/domain/entity/sales_data_entity.dart';

class SalesDataModel extends SalesDataEntity {
  const SalesDataModel({
    required String startDate,
    required String endDate,
    required List<WeeklySalesModel> weeklySales,
  }) : super(
          startDate: startDate,
          endDate: endDate,
          weeklySales: weeklySales,
        );

  factory SalesDataModel.fromJson(Map<String, dynamic> json) {
    return SalesDataModel(
      startDate: json['start_date'],
      endDate: json['end_date'],
      weeklySales: (json['data'] as List)
          .map((e) => WeeklySalesModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate,
      'end_date': endDate,
      'data': weeklySales.map((e) => (e as WeeklySalesModel).toJson()).toList(),
    };
  }
}

class WeeklySalesModel extends WeeklySalesEntity {
  const WeeklySalesModel({
    required String week,
    required int salesPredictions,
  }) : super(
          week: week,
          salesPredictions: salesPredictions,
        );

  factory WeeklySalesModel.fromJson(Map<String, dynamic> json) {
    return WeeklySalesModel(
      week: json['week'],
      salesPredictions: json['sales_predictions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'week': week,
      'sales_predictions': salesPredictions,
    };
  }
}
