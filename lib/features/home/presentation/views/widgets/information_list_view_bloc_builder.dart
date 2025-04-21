import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/features/home/presentation/manger/stock_data_cubit/stock_data_cubit.dart';
import 'package:save_bite/features/home/presentation/views/widgets/custom_loading_indicator.dart';
import 'package:save_bite/features/home/presentation/views/widgets/custom_message_widget.dart';
import 'package:save_bite/features/home/presentation/views/widgets/information_iteam_list_view.dart';

class InformationListViewBlockBuilder extends StatelessWidget {
  const InformationListViewBlockBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockDataCubit, StockDataState>(
      builder: (context, state) {
        if (state is StockDatatIntialInitial) {
          return CustomAllertWidget();
        } else if (state is GetStockLoading) {
          return CustomLoadingindicator();
        } else if (state is GetStockFailure) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is GetStockSuccess) {
          return InformationIteamListView(
            stockDataModel: state.stockDataModel,
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
