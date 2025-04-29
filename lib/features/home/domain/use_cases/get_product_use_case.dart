import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/home/data/models/product_model.dart';
import 'package:save_bite/features/home/domain/repos/home_repo.dart';

class GetProductUseCase {
  final HomeRepo homeRepo;

  GetProductUseCase({required this.homeRepo});

  Future<Either<Failure, List<ProductModel>>> call(
      {String? productName, String? sortBy}) {
    return homeRepo.getProducts(
      productName: productName,
      sortBy: sortBy,
    );
  }
}
