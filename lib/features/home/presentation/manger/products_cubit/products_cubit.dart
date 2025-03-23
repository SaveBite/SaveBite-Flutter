import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:save_bite/features/home/data/models/product_model.dart';
import 'package:save_bite/features/home/domain/use_cases/add_product_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/get_product_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/upload_products_use_case.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.getProductUseCase, this.uploadProductsUseCase,
      this.addProductUseCase)
      : super(ProductsInitial());
  List<ProductModel>? products;
  final GetProductUseCase getProductUseCase;
  final UploadProductsUseCase uploadProductsUseCase;
  final AddProductUseCase addProductUseCase;
  File? productsFile;
  String? productsName;
  String? sortBy;
  String? date,
      productName,
      category,
      unitPrice,
      stockQuantity,
      reorderLevel,
      reorderQuantity,
      unitsSold,
      salesValue,
      month;

  Future<void> uploadProducts() async {
    emit(UploadProductsLoading());
    var result = await uploadProductsUseCase.call(productsFile: productsFile!);
    result.fold((failure) {
      emit(
        UploadProductsFailure(errorMessage: failure.errorMessage),
      );
    }, (data) {
      emit(UploadProductsSuccess(message: data));
    });
  }

  Future<void> getProduct({String? productsName}) async {
    emit(GetProductsLoaidng());
    var result = await getProductUseCase.call();
    result.fold((failure) {
      emit(GetProductsFailure(errorMesssage: failure.errorMessage));
    }, (data) {
      products = data;
      emit(GetProductsSuccess(products: data));
    });
  }

  Future<void> serachForProduct({String? productsName}) async {
    emit(GetProductsLoaidng());
    var result = await getProductUseCase.call(
      productName: productsName,
    );
    result.fold((failure) {
      emit(GetProductsFailure(errorMesssage: failure.errorMessage));
    }, (data) {
      products = data;
      emit(GetProductsSuccess(products: data));
    });
  }

  Future<void> sortProductsBy() async {
    emit(GetProductsLoaidng());
    var result = await getProductUseCase.call(
      sortBy: sortBy,
    );
    result.fold((failure) {
      emit(GetProductsFailure(errorMesssage: failure.errorMessage));
    }, (data) {
      products = data;
      emit(GetProductsSuccess(products: data));
    });
  }

  Future<void> addProduct() async {
    var result = await addProductUseCase.call(
      date: date!,
      productName: productName!,
      category: category!,
      unitPrice: unitPrice!,
      stockQuantity: stockQuantity!,
      reorderLevel: reorderLevel!,
      reorderQuantity: reorderQuantity!,
      unitsSold: unitsSold!,
      salesValue: salesValue!,
      month: month!,
    );
    result.fold((failure) {
      emit(AddProductFailure(errorMessage: failure.errorMessage));
    }, (data) {
      print('======================================');
      print(data);
      print('======================================');
      emit(AddProductSuccess());
    });
  }
}
