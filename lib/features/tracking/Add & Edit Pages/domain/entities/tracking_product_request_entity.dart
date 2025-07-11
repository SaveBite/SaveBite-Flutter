// domain/entities/tracking_product.dart
import 'package:equatable/equatable.dart';

class TrackingProduct extends Equatable {
  final int? id;
  final String name;
  final String numberId;
  final String category;
  final String label;
  final int quantity;
  final String? startDate;
  final String endDate;
  final String? imageUrl;

  const TrackingProduct({
    this.id,
    required this.name,
    required this.numberId,
    required this.category,
    required this.label,
    required this.quantity,
    this.startDate,
    required this.endDate,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    numberId,
    category,
    label,
    quantity,
    startDate,
    endDate,
    imageUrl,
  ];
}