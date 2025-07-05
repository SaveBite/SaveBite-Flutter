// domain/use_cases/add_tracking_product_use_case.dart
import 'dart:io';
import 'package:dartz/dartz.dart';
import '../entities/tracking_product_request_entity.dart';
import '../repos/tracking_product_repo.dart';

class AddTrackingProductUseCase {
  final TrackingRepository repository;

  AddTrackingProductUseCase(this.repository);

  Future<Either<Exception, TrackingProduct>> execute({
    required String name,
    required String numberId,
    required String category,
    required String label,
    required int quantity,
    String? startDate,
    required String endDate,
    File? image,
  }) {
    return repository.addTrackingProduct(
      name: name,
      numberId: numberId,
      category: category,
      label: label,
      quantity: quantity,
      startDate: startDate,
      endDate: endDate,
      image: image,
    );
  }
}