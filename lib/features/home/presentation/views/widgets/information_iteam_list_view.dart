import 'package:flutter/material.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/features/home/data/models/information_iteam_model.dart';
import 'package:save_bite/features/home/data/models/stock_data_model.dart';
import 'package:save_bite/features/home/presentation/views/widgets/information_iteam.dart';

class InformationIteamListView extends StatefulWidget {
  const InformationIteamListView({super.key, required this.stockDataModel});
  final StockDataModel stockDataModel;

  @override
  State<InformationIteamListView> createState() =>
      _InformationIteamListViewState();
}

class _InformationIteamListViewState extends State<InformationIteamListView> {
  List<InformationIteamModel> iteamList = [
    InformationIteamModel(
      title: 'Stock on Hand',
      image: Assets.imagesStockOnHand,
    ),
    InformationIteamModel(
      title: 'Positive Stock',
      image: Assets.imagesPostitiveStock,
    ),
    InformationIteamModel(
      title: 'Negative Stock',
      image: Assets.imagesNegativeStock,
    ),
    InformationIteamModel(
      title: 'Below Par',
      image: Assets.imagesBellowBar,
    ),
    InformationIteamModel(
      title: 'Below Minimum',
      image: Assets.imagesBellowMinmum,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    List<String> stockDate = [
      widget.stockDataModel.stockOnHand,
      widget.stockDataModel.positiveStock,
      widget.stockDataModel.negativeStock,
      widget.stockDataModel.belowPar,
      widget.stockDataModel.belowMinimum,
    ];
    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: iteamList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: InformationIteam(
                value: stockDate[index],
                informationIteamModel: iteamList[index],
              ),
            );
          }),
    );
  }
}
