import 'package:equatable/equatable.dart';

class SalesDataEntity extends Equatable {
  final String startDate;
  final String endDate;
  final List<WeeklySalesEntity> weeklySales;

  const SalesDataEntity({
    required this.startDate,
    required this.endDate,
    required this.weeklySales,
  });

  @override
  List<Object?> get props => [startDate, endDate, weeklySales];
}

class WeeklySalesEntity extends Equatable {
  final String week;
  final int salesPredictions;

  const WeeklySalesEntity({
    required this.week,
    required this.salesPredictions,
  });

  @override
  List<Object?> get props => [week, salesPredictions];
}
