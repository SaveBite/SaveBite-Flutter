import 'package:save_bite/features/tracking/display_tracking_data/domain/entity/tracking_product_entity.dart';

class TrackingProductModel extends TrackingProductEntity {
  const TrackingProductModel({
    required super.id,
    required super.name,
    required super.numberId,
    required super.category,
    required super.quantity,
    required super.label,
    required super.startDate,
    required super.endDate,
    required super.status,
    super.image,
  });

  factory TrackingProductModel.fromJson(Map<String, dynamic> json) {
    return TrackingProductModel(
      id: json['id'],
      name: json['name'],
      numberId: json['numberId'],
      category: json['category'],
      quantity: json['quantity'],
      label: json['label'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      status: json['status'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'numberId': numberId,
      'category': category,
      'quantity': quantity,
      'label': label,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'status': status,
      'image': image,
    };
  }
}
