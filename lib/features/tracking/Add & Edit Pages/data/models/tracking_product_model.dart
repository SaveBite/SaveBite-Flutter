// data/models/tracking_product_model.dart
import 'package:equatable/equatable.dart';

import '../../domain/entities/tracking_product_request_entity.dart';

class TrackingProductModel extends Equatable {
  final int? id;
  final String name;
  final String numberId;
  final String category;
  final String label;
  final int quantity;
  final String? startDate;
  final String endDate;
  final String? imageUrl;

  const TrackingProductModel({
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

  factory TrackingProductModel.fromJson(Map<String, dynamic> json) {
    return TrackingProductModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      numberId: json['numberId'] as String,
      category: json['category'] as String,
      label: json['label'] as String,
      quantity: int.parse(json['quantity'].toString()),
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String,
      imageUrl: json['image'] as String?,
    );
  }

  TrackingProduct toEntity() {
    return TrackingProduct(
      id: id,
      name: name,
      numberId: numberId,
      category: category,
      label: label,
      quantity: quantity,
      startDate: startDate,
      endDate: endDate,
      imageUrl: imageUrl,
    );
  }

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