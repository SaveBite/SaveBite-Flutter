import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:save_bite/features/home/data/models/stock_data_model.dart';
import 'package:save_bite/features/home/domain/use_cases/get_stock_data_use_case.dart';

part 'Stock_data_state.dart';

class StockDataCubit extends Cubit<StockDataState> {
  StockDataCubit(
    this.getStockDataUseCase,
  ) : super(StockDatatIntialInitial());
  final GetStockDataUseCase getStockDataUseCase;
  StockDataModel? stockDataModel;

  Future<void> getStockData() async {
    emit(GetStockLoading());
    var result = await getStockDataUseCase.call();
    result.fold((failure) {
      emit(GetStockFailure(errorMessage: failure.errorMessage));
    }, (data) {
      emit(GetStockSuccess(stockDataModel: data));
    });
  }

  void removeAlertMessage() {
    emit(RemoveAletMessageState());
  }
}
