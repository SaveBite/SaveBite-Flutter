import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/home/domain/repos/home_repo.dart';

class UploadProductsUseCase {
  final HomeRepo homeRepo;

  UploadProductsUseCase({required this.homeRepo});

  Future<Either<Failure, String>> call({required File productsFile}) {
    return homeRepo.uploadProducts(productsFile: productsFile);
  }
}
