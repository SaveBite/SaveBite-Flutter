import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_message_widget.dart';
import 'package:save_bite/features/home/presentation/manger/products_cubit/products_cubit.dart';
import 'package:save_bite/features/home/presentation/manger/stock_data_cubit/stock_data_cubit.dart';
import 'package:save_bite/features/home/presentation/views/widgets/custom_loading_indicator.dart';
import 'package:save_bite/features/home/presentation/views/widgets/product_table.dart';
import 'package:save_bite/features/home/presentation/views/widgets/tabler_header_list_view.dart';
import 'package:save_bite/features/home/presentation/views/widgets/upload_file_widget.dart';

class UploadProductsBlocBuilder extends StatelessWidget {
  const UploadProductsBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is UploadProductsSuccess) {
          BlocProvider.of<ProductsCubit>(context).getProduct();
          BlocProvider.of<StockDataCubit>(context).getStockData();
        } else if (state is UploadProductsFailure) {
          showOverlayWidget(context, state.errorMessage);
        }

        if (state is AddProductSuccess) {
          BlocProvider.of<ProductsCubit>(context).getProduct();
          BlocProvider.of<StockDataCubit>(context).getStockData();
        } else if (state is AddProductFailure) {
          showOverlayWidget(context, state.errorMessage);
          BlocProvider.of<ProductsCubit>(context).getProduct();
          BlocProvider.of<StockDataCubit>(context).getStockData();
        }
      },
      builder: (context, state) {
        if (state is ProductsInitial) {
          return Column(
            children: [
              TablerHeaderListView(),
              SizedBox(
                height: 15,
              ),
              UploadFilesWidget(),
            ],
          );
        } else if (state is GetProductsSuccess) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ProductTable(
                products: state.products,
              ),
            ),
          );
        } else if (state is GetProductsFailure) {
          return Center(
            child: Text(state.errorMesssage),
          );
        } else if (state is GetProductsLoaidng ||
            state is UploadProductsLoading) {
          return CustomLoadingindicator();
        } else {
          return SizedBox();
        }
      },
    );
  }
}
