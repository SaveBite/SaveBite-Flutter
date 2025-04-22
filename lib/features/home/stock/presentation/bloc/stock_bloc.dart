import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/failure/failure.dart';
import '../../domain/entites/product_filter_entity.dart';
import '../../domain/entites/product_stock_response_entity.dart';
import '../../domain/repos/stock_repo.dart';
import '../../domain/usecases/stock_usecase.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final StockUseCase stockUseCase;

  StockBloc({required this.stockUseCase}) : super(StockInitial()) {
    on<GetStockProductsEvent>(_onGetStockProducts);
  }

  Future<void> _onGetStockProducts(
      GetStockProductsEvent event, Emitter<StockState> emit) async {
    emit(StockLoading());
    print("📦 StockBloc: Fetching stock...");

    final Either<Failure, ProductStockResponseEntity> result =
    await stockUseCase(event.filter); // ✅ Now using the use case

    result.fold(
          (failure) => emit(StockError(message: failure.errorMessage)),
          (stockData) => emit(StockLoaded(stockData: stockData)),
    );
  }
}