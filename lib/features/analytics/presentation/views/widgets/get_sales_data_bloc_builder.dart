import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/features/analytics/presentation/manger/sales_cubit/sales_cubit.dart';
import 'package:save_bite/features/analytics/presentation/views/widgets/sales_chart_widget.dart';
import 'package:save_bite/features/home/presentation/views/widgets/custom_loading_indicator.dart';

class GetSalesDataBlocBuilder extends StatelessWidget {
  const GetSalesDataBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesCubit, SalesState>(
      builder: (context, state) {
        if (state is SalesLoading) {
          return CustomLoadingindicator();
        } else if (state is SalesLoaded) {
          return SalesChartWidget(salesData: state.salesData);
        } else if (state is SalesError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
