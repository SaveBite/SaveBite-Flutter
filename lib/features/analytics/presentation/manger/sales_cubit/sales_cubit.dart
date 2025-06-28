import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:save_bite/features/analytics/domain/entity/sales_data_entity.dart';
import 'package:save_bite/features/analytics/domain/use_case/get_sales_data_use_case.dart';

part 'sales_state.dart';

class SalesCubit extends Cubit<SalesState> {
  final GetSalesDataUseCase getSalesDataUseCase;

  SalesCubit({required this.getSalesDataUseCase}) : super(SalesInitial());

  Future<void> fetchSalesData() async {
    emit(SalesLoading());
    final result = await getSalesDataUseCase();
    result.fold(
      (failure) => emit(SalesError(failure.errorMessage)),
      (salesData) => emit(SalesLoaded(salesData)),
    );
  }
}
