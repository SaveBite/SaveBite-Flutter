part of 'fetch_anayltics_details_cubit.dart';

sealed class FetchAnaylticsDetailsState extends Equatable {
  const FetchAnaylticsDetailsState();

  @override
  List<Object> get props => [];
}

final class FetchAnaylticsDetailsInitial extends FetchAnaylticsDetailsState {}

final class FetchAnaylticsDetailsLoading extends FetchAnaylticsDetailsState {}

final class FetchAnaylticsDetailsFailure extends FetchAnaylticsDetailsState {
  final String errorMessage;

  const FetchAnaylticsDetailsFailure({required this.errorMessage});
}

final class FetchAnaylticsDetailsSuccess extends FetchAnaylticsDetailsState {
  final AnalyticsModel analyticsModel;

  const FetchAnaylticsDetailsSuccess({required this.analyticsModel});
}
