part of 'products_cubit.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class GetProductsLoaidng extends ProductsState {}

final class GetProductsSuccess extends ProductsState {
  final List<ProductModel> products;

  const GetProductsSuccess({required this.products});
}

final class GetProductsFailure extends ProductsState {
  final String errorMesssage;

  const GetProductsFailure({required this.errorMesssage});
}

final class UploadProductsLoading extends ProductsState {}

final class UploadProductsSuccess extends ProductsState {
  final String message;

  const UploadProductsSuccess({required this.message});
}

final class UploadProductsFailure extends ProductsState {
  final String errorMessage;

  const UploadProductsFailure({required this.errorMessage});
}

final class AddProductSuccess extends ProductsState {
  const AddProductSuccess();
}

final class AddProductFailure extends ProductsState {
  final String errorMessage;

  const AddProductFailure({required this.errorMessage});
}
