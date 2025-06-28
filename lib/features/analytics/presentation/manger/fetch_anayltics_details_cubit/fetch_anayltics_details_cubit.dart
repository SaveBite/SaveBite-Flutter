import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:save_bite/features/analytics/data/model/anyltics_model.dart';
import 'package:save_bite/features/analytics/domain/use_case/fetch_anyltics_details_use_case.dart';

part 'fetch_anayltics_details_state.dart';

class FetchAnaylticsDetailsCubit extends Cubit<FetchAnaylticsDetailsState> {
  FetchAnaylticsDetailsCubit(this.fetchAnylticsDetailsUseCase)
      : super(FetchAnaylticsDetailsInitial());
  AnalyticsModel? analyticsModel;
  final FetchAnylticsDetailsUseCase fetchAnylticsDetailsUseCase;

  Future<void> fetchAnaylticsDetails() async {
    emit(FetchAnaylticsDetailsLoading());
    var result = await fetchAnylticsDetailsUseCase.call();
    result.fold((failure) {
      emit(FetchAnaylticsDetailsFailure(errorMessage: failure.errorMessage));
    }, (analyticsModel) {
      emit(FetchAnaylticsDetailsSuccess(analyticsModel: analyticsModel));
    });
  }
}
