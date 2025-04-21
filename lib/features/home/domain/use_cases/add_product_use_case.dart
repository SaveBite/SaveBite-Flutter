import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/home/data/models/product_model.dart';
import 'package:save_bite/features/home/domain/repos/home_repo.dart';

class AddProductUseCase {
  final HomeRepo homeRepo;

  AddProductUseCase({required this.homeRepo});

  Future<Either<Failure, ProductModel>> call({
    required String date,
    required String productName,
    required String category,
    required String unitPrice,
    required String stockQuantity,
    required String reorderLevel,
    required String reorderQuantity,
    required String unitsSold,
    required String salesValue,
    required String month,
  }) {
    return homeRepo.addProduct(
      date: date,
      productName: productName,
      category: category,
      unitPrice: unitPrice,
      stockQuantity: stockQuantity,
      reorderLevel: reorderLevel,
      reorderQuantity: reorderQuantity,
      unitsSold: unitsSold,
      salesValue: salesValue,
      month: month,
    );
  }
}
