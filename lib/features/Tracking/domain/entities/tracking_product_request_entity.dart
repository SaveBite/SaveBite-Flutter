import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class TrackingProductEntity extends Equatable {
  final int? id;
  final String name;
  final String numberId;
  final String category;
  final int quantity;
  final String label;
  final String? startDate;
  final String endDate;
  final XFile? image;

  const TrackingProductEntity({
    this.id,
    required this.name,
    required this.numberId,
    required this.category,
    required this.quantity,
    required this.label,
    this.startDate,
    required this.endDate,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, numberId, category, quantity, label, startDate, endDate, image];
}