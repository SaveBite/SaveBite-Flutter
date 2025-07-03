import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/features/home/presentation/views/widgets/custom_loading_indicator.dart';
import 'package:save_bite/features/tracking/display_tracking_data/presentation/manger/tarcking_cubit/tracking_cubit.dart';
import 'package:save_bite/features/tracking/display_tracking_data/presentation/views/widgets/tracking_table.dart';

class ExpiredViewBody extends StatelessWidget {
  const ExpiredViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingCubit, TrackingState>(
      builder: (context, state) {
        if (state is GetTrackingProductsSuccess) {
          return TrackingTaple(
            items: state.trackingProducts,
          );
        } else if (state is GetTrackingProductsFailurs) {
          return Center(
            child: Text(state.errorMesaage),
          );
        } else if (state is GetTrackingProductsLoading) {
          return CustomLoadingindicator();
        } else {
          return SizedBox();
        }
      },
    );
  }
}
