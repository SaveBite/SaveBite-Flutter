import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tracking_product_event.dart';
part 'tracking_product_state.dart';

class TrackingProductBloc extends Bloc<TrackingProductEvent, TrackingProductState> {
  TrackingProductBloc() : super(TrackingProductInitial()) {
    on<TrackingProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
