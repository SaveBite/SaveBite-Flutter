part of 'stock_bloc.dart';

abstract class StockState extends Equatable {
  const StockState();
  @override
  List<Object> get props => [];
}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockLoaded extends StockState {
  final ProductStockResponseEntity stockData;

  const StockLoaded({required this.stockData});

  @override
  List<Object> get props => [stockData];
}

class StockError extends StockState {
  final String message;

  const StockError({required this.message});

  @override
  List<Object> get props => [message];
}