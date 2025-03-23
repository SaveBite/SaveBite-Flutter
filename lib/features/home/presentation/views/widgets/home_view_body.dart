import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/features/home/data/date_sources/home_remote_data_sources.dart';
import 'package:save_bite/features/home/data/repos/home_repo_imp.dart';
import 'package:save_bite/features/home/domain/use_cases/add_product_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/get_product_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/get_stock_data_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/upload_products_use_case.dart';
import 'package:save_bite/features/home/presentation/manger/products_cubit/products_cubit.dart';
import 'package:save_bite/features/home/presentation/manger/stock_data_cubit/stock_data_cubit.dart';
import 'package:save_bite/features/home/presentation/views/widgets/add_iteam_widget.dart';
import 'package:save_bite/features/home/presentation/views/widgets/custom_filter_widget.dart';
import 'package:save_bite/features/home/presentation/views/widgets/information_list_view_bloc_builder.dart';
import 'package:save_bite/features/home/presentation/views/widgets/search_product_field.dart';
import 'package:save_bite/features/home/presentation/views/widgets/upload_products_bloc_builder.dart';
import 'package:save_bite/features/home/presentation/views/widgets/user_info.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsCubit(
            GetProductUseCase(
              homeRepo: HomeRepoImp(
                homeRemoteDataSources: HomeRemoteDataSourcesImp(
                  dio: Dio(),
                ),
              ),
            ),
            UploadProductsUseCase(
              homeRepo: HomeRepoImp(
                homeRemoteDataSources: HomeRemoteDataSourcesImp(
                  dio: Dio(),
                ),
              ),
            ),
            AddProductUseCase(
              homeRepo: HomeRepoImp(
                homeRemoteDataSources: HomeRemoteDataSourcesImp(
                  dio: Dio(),
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => StockDataCubit(
            GetStockDataUseCase(
              homeRepo: HomeRepoImp(
                homeRemoteDataSources: HomeRemoteDataSourcesImp(
                  dio: Dio(),
                ),
              ),
            ),
          ),
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserInfo(),
            SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: InformationListViewBlockBuilder(),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Row(
                children: [
                  SearchProductField(),
                  Spacer(),
                  CustomFilterWidget(),
                  SizedBox(
                    width: 8,
                  ),
                  AddIteamWidget(),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: UploadProductsBlocBuilder(),
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
