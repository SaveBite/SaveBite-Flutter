import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/features/analytics/presentation/manger/fetch_anayltics_details_cubit/fetch_anayltics_details_cubit.dart';
import 'package:save_bite/features/analytics/presentation/manger/sales_cubit/sales_cubit.dart';
import 'package:save_bite/features/analytics/presentation/views/widgets/fetch_anyltics_details_bloc_builder.dart';
import 'package:save_bite/features/analytics/presentation/views/widgets/get_sales_data_bloc_builder.dart';

class AnylticsViewBody extends StatefulWidget {
  const AnylticsViewBody({super.key});

  @override
  State<AnylticsViewBody> createState() => _AnylticsViewBodyState();
}

class _AnylticsViewBodyState extends State<AnylticsViewBody> {
  @override
  void initState() {
    BlocProvider.of<FetchAnaylticsDetailsCubit>(context)
        .fetchAnaylticsDetails();
    BlocProvider.of<SalesCubit>(context).fetchSalesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FetchAnaylticsDetailsBlocBuilder(),
            SizedBox(
              height: 30,
            ),
            GetSalesDataBlocBuilder(),
          ],
        ),
      ),
    );
  }
}
