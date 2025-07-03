part of 'tracking_cubit.dart';

sealed class TrackingState extends Equatable {
  const TrackingState();

  @override
  List<Object> get props => [];
}

final class TrackingInitial extends TrackingState {}

final class GetTrackingProductsLoading extends TrackingState {}

final class GetTrackingProductsSuccess extends TrackingState {
  final List<TrackingProductEntity> trackingProducts;

  const GetTrackingProductsSuccess({required this.trackingProducts});
}

final class GetTrackingProductsFailurs extends TrackingState {
  final String errorMesaage;

  const GetTrackingProductsFailurs({required this.errorMesaage});
}
