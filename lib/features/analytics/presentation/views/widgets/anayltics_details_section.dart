import 'package:flutter/material.dart';
import 'package:save_bite/features/analytics/data/model/anyltics_model.dart';
import 'package:save_bite/features/analytics/presentation/views/widgets/category_overstocking_widget.dart';
import 'package:save_bite/features/analytics/presentation/views/widgets/reorder_acuracy_rate_widget.dart';
import 'package:save_bite/features/analytics/presentation/views/widgets/revenue_widget.dart';
import 'package:save_bite/features/analytics/presentation/views/widgets/spila_age_rate_widgte.dart';
import 'package:save_bite/features/analytics/presentation/views/widgets/stock_turn_over_widget.dart';
import 'package:save_bite/features/analytics/presentation/views/widgets/waste_to_sales_ratio_widget.dart';

class AnaylticsDetailsSection extends StatelessWidget {
  final AnalyticsModel analyticsModel;
  const AnaylticsDetailsSection({
    super.key,
    required this.analyticsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: 162,
            child: Row(
              children: [
                StockTurnOverWidget(
                  stockTurnOverRate: analyticsModel.stockTurnoverRate,
                  stockTurnOverRateChange:
                      analyticsModel.stockTurnoverRateChange,
                ),
                SizedBox(
                  width: 8,
                ),
                ReorderAcuracyRateWidget(
                  reorderAcuracyRate: analyticsModel.reorderAccuracyRate,
                  reorderAcuracyRateChange:
                      analyticsModel.reorderAccuracyRateChange,
                ),
                SizedBox(
                  width: 8,
                ),
                CategoryOverstockingWidget(
                  categoryOverstockingProducts:
                      analyticsModel.categoryOverstockingProducts,
                  categoryOverstockingProductsValues:
                      analyticsModel.categoryOverstockingValues,
                  categoryOverstockingProductsValuesChanges:
                      analyticsModel.categoryOverstockingChangeValues,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpoilaAgeRateWidgte(
                spoilAgeRate: 50,
                spoilAgeRateChange: -12.1,
              ),
              SizedBox(
                width: 8,
              ),
              WasteToSalesRatioWidget(
                wasteToSalesRatio: 50,
                wasteToSalesRatioChange: -12.1,
              ),
              SizedBox(
                width: 8,
              ),
              RevenueWidget(
                revenueRate: analyticsModel.revenue,
                revenueRateChange: analyticsModel.revenueChange,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
