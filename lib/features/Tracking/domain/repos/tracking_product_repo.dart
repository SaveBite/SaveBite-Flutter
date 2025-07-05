// domain/repositories/tracking_repository.dart
import 'dart:io';
import 'package:dartz/dartz.dart';
import '../entities/tracking_product_request_entity.dart';

abstract class TrackingRepository {
  Future<Either<Exception, TrackingProduct>> addTrackingProduct({
    required String name,
    required String numberId,
    required String category,
    required String label,
    required int quantity,
    String? startDate,
    required String endDate,
    File? image,
  });

  Future<Either<Exception, TrackingProduct>> updateTrackingProduct({
    required int id,
    required String name,
    required String numberId,
    required String category,
    required String label,
    required int quantity,
    String? startDate,
    required String endDate,
    File? image,
  });

  Future<Either<Exception, String>> extractDateFromImage(File image);
}