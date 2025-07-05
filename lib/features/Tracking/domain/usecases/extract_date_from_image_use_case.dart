// domain/use_cases/extract_date_from_image_use_case.dart
import 'dart:io';
import 'package:dartz/dartz.dart';
import '../repos/tracking_product_repo.dart';

class ExtractDateFromImageUseCase {
  final TrackingRepository repository;

  ExtractDateFromImageUseCase(this.repository);

  Future<Either<Exception, String>> execute(File image) {
    return repository.extractDateFromImage(image);
  }
}