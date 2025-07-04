part of 'sales_cubit.dart';

abstract class SalesState extends Equatable {
  const SalesState();

  @override
  List<Object> get props => [];
}

class SalesInitial extends SalesState {}

class SalesLoading extends SalesState {}

class SalesLoaded extends SalesState {
  final SalesDataEntity salesData;

  const SalesLoaded(this.salesData);

  @override
  List<Object> get props => [salesData];
}

class SalesError extends SalesState {
  final String message;

  const SalesError(this.message);

  @override
  List<Object> get props => [message];
}
