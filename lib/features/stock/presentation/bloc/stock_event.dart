part of 'stock_bloc.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();
  @override
  List<Object> get props => [];
}

class GetStockProductsEvent extends StockEvent {
  final ProductFilterEntity filter;

  const GetStockProductsEvent({required this.filter});

  @override
  List<Object> get props => [filter];
}
