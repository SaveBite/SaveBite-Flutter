import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/features/analytics/presentation/manger/fetch_anayltics_details_cubit/fetch_anayltics_details_cubit.dart';
import 'package:save_bite/features/analytics/presentation/views/widgets/anayltics_details_section.dart';
import 'package:save_bite/features/home/presentation/views/widgets/custom_loading_indicator.dart';

class FetchAnaylticsDetailsBlocBuilder extends StatelessWidget {
  const FetchAnaylticsDetailsBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAnaylticsDetailsCubit, FetchAnaylticsDetailsState>(
      builder: (context, state) {
        if (state is FetchAnaylticsDetailsLoading) {
          return CustomLoadingindicator();
        } else if (state is FetchAnaylticsDetailsFailure) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is FetchAnaylticsDetailsSuccess) {
          return AnaylticsDetailsSection(analyticsModel: state.analyticsModel);
        } else {
          return SizedBox();
        }
      },
    );
  }
}
