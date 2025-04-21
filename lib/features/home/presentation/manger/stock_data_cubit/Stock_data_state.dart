part of 'stock_data_cubit.dart';

sealed class StockDataState extends Equatable {
  const StockDataState();

  @override
  List<Object> get props => [];
}

final class StockDatatIntialInitial extends StockDataState {}

final class RemoveAletMessageState extends StockDataState {}

final class GetStockLoading extends StockDataState {}

final class GetStockSuccess extends StockDataState {
  final StockDataModel stockDataModel;

  const GetStockSuccess({required this.stockDataModel});
}

final class GetStockFailure extends StockDataState {
  final String errorMessage;

  const GetStockFailure({required this.errorMessage});
}
