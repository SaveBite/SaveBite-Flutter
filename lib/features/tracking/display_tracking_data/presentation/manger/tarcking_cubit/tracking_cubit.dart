import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/entity/tracking_product_entity.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/use_case/delete_tracking_product_use_case.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/use_case/get_tracking_products_use_case.dart';

part 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  final GetTrackingProductsUseCase getTrackingProductsUseCase;
  final DeleteTrackingProductUseCase deleteTrackingProductUseCase;

  TrackingCubit({
    required this.getTrackingProductsUseCase,
    required this.deleteTrackingProductUseCase,
  }) : super(TrackingInitial());

  Future<void> getTrackingProducts() async {
    emit(GetTrackingProductsLoading());
    final result = await getTrackingProductsUseCase.call();
    result.fold(
      (failure) =>
          emit(GetTrackingProductsFailurs(errorMesaage: failure.errorMessage)),
      (data) => emit(GetTrackingProductsSuccess(trackingProducts: data)),
    );
  }

  Future<void> deleteTrackingProduct(int id) async {
    final result = await deleteTrackingProductUseCase.call(id);
    result.fold(
      (failure) =>
          emit(GetTrackingProductsFailurs(errorMesaage: failure.errorMessage)),
      (_) => getTrackingProducts(), // Reload after delete
    );
  }
}
