import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/analytics/domain/use_case/fetch_anyltics_details_use_case.dart';
import 'package:save_bite/features/analytics/domain/use_case/get_sales_data_use_case.dart';
import 'package:save_bite/features/analytics/presentation/manger/fetch_anayltics_details_cubit/fetch_anayltics_details_cubit.dart';
import 'package:save_bite/features/analytics/presentation/manger/sales_cubit/sales_cubit.dart';
import 'package:save_bite/features/analytics/presentation/views/widgets/anyltics_view_body.dart';
import 'package:save_bite/injection_container.dart';

class AnylticsView extends StatefulWidget {
  const AnylticsView({super.key});

  @override
  State<AnylticsView> createState() => _AnylticsViewState();
}

class _AnylticsViewState extends State<AnylticsView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchAnaylticsDetailsCubit(
            sl.get<FetchAnylticsDetailsUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              SalesCubit(getSalesDataUseCase: sl.get<GetSalesDataUseCase>()),
        ),
      ],
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Analytics',
            style: AppStyles.styleMedium19.copyWith(
              color: Color(0xff000000),
              fontSize: 19,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Transform.scale(
                scale: .4, child: SvgPicture.asset(Assets.imagesReturnBack)),
          ),
        ),
        body: AnylticsViewBody(),
      ),
    );
  }
}
