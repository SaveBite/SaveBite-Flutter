import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/features/authentication/login/data/model/save_user_data.dart';
import 'package:save_bite/features/home/presentation/manger/products_cubit/products_cubit.dart';
import 'package:save_bite/features/home/presentation/manger/stock_data_cubit/stock_data_cubit.dart';
import 'package:save_bite/features/home/presentation/views/widgets/add_iteam_widget.dart';
import 'package:save_bite/features/home/presentation/views/widgets/custom_filter_widget.dart';
import 'package:save_bite/features/home/presentation/views/widgets/information_list_view_bloc_builder.dart';
import 'package:save_bite/features/home/presentation/views/widgets/search_product_field.dart';
import 'package:save_bite/features/home/presentation/views/widgets/upload_products_bloc_builder.dart';
import 'package:save_bite/features/home/presentation/views/widgets/user_info.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
    if (SaveUserData.rememberMe == true) {
      BlocProvider.of<ProductsCubit>(context).getProduct();
      BlocProvider.of<StockDataCubit>(context).getStockData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
