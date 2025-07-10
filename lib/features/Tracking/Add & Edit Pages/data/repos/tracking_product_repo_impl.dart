// data/repositories/tracking_repository_impl.dart
import 'dart:io';
import 'package:dartz/dartz.dart';

import '../../domain/entities/tracking_product_request_entity.dart';
import '../../domain/repos/tracking_product_repo.dart';
import '../datasources/tracking_product_remote_data_source.dart';


class TrackingRepositoryImpl implements TrackingRepository {
  final TrackingRemoteDataSource remoteDataSource;

  TrackingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, TrackingProduct>> addTrackingProduct({
    required String name,
    required String numberId,
    required String category,
    required String label,
    required int quantity,
    String? startDate,
    required String endDate,
    File? image,
  }) async {
    return (await remoteDataSource.addTrackingProduct(
      name: name,
      numberId: numberId,
      category: category,
      label: label,
      quantity: quantity,
      startDate: startDate,
      endDate: endDate,
      image: image,
    )).map((model) => model.toEntity());
  }

  @override
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
  }) async {
    return (await remoteDataSource.updateTrackingProduct(
      id: id,
      name: name,
      numberId: numberId,
      category: category,
      label: label,
      quantity: quantity,
      startDate: startDate,
      endDate: endDate,
      image: image,
    )).map((model) => model.toEntity());
  }

  @override
  Future<Either<Exception, String>> extractDateFromImage(File image) async {
    return remoteDataSource.extractDateFromImage(image);
  }
}