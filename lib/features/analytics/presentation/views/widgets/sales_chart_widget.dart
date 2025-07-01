import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/analytics/domain/entity/sales_data_entity.dart';

extension LogExt on double {
  double log10() => log(this) / ln10;
}

class SalesChartWidget extends StatelessWidget {
  final SalesDataEntity salesData;

  const SalesChartWidget({super.key, required this.salesData});

  @override
  Widget build(BuildContext context) {
    final DateTime startDate = DateTime.parse(salesData.startDate);
    final DateTime endDate = DateTime.parse(salesData.endDate);

    final String formattedStartDate =
        DateFormat('d MMMM', 'en_US').format(startDate);
    final String formattedEndDate =
        DateFormat('d MMMM', 'en_US').format(endDate);
    final String dateRangeText = '$formattedStartDate - $formattedEndDate';

    if (salesData.weeklySales.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: const Center(
          child: Text('No sales data available to display chart.'),
        ),
      );
    }

    final uniqueSales = <String, double>{};
    for (var item in salesData.weeklySales) {
      uniqueSales[item.week] = item.salesPredictions.toDouble();
    }
    final cleanedWeeklySales = uniqueSales.entries.toList();
    final limitedSales = cleanedWeeklySales.take(4).toList();

    List<FlSpot> spots = [];
    List<String> weekLabels = [];

    for (int i = 0; i < limitedSales.length; i++) {
      spots.add(FlSpot(i.toDouble(), limitedSales[i].value));
      weekLabels.add('Week ${i + 1}');
    }

    double minSales = limitedSales.map((e) => e.value).reduce(min);
    double maxSales = limitedSales.map((e) => e.value).reduce(max);

    double rawInterval = (maxSales - minSales) / 5;

    double roundToNiceNumber(double value) {
      double magnitude = pow(10, value.log10().floorToDouble()).toDouble();
      double residual = value / magnitude;
      if (residual < 1.5) return 1 * magnitude;
      if (residual < 3) return 2 * magnitude;
      if (residual < 7) return 5 * magnitude;
      return 10 * magnitude;
    }

    double interval = roundToNiceNumber(rawInterval);
    double minY = (minSales / interval).floor() * interval;
    double maxY = minY + interval * 5;

    final List<Color> lineGradientColors = [
      const Color(0xFFE040FB).withOpacity(0.8),
      const Color(0xFFF48FB1).withOpacity(0.8),
    ];

    final List<Color> areaGradientColors = [
      const Color(0xFFE040FB).withOpacity(0.3),
      const Color(0xFFF48FB1).withOpacity(0.1),
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), // ✅ Border radius = 16
        color: Colors.white,
        // ✅ لا يوجد Border ظاهر
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sales Analytics',
            style: AppStyles.styleBold19.copyWith(
              color: const Color(0xff5EDA42),
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.scale(
                    scale: 1,
                    child: Image.asset(Assets.imagesCalender22),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    dateRangeText,
                    style: AppStyles.styleRegular11.copyWith(
                      color: const Color(0xff999999),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 1.7,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false, // ✅ no vertical lines
                  horizontalInterval: interval,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: const Color(0xfff3f3f3),
                    strokeWidth: 1,
                    dashArray: [4, 4], // ✅ dashed horizontal lines
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 60,
                      interval: interval,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          meta: meta,
                          space: 8,
                          child: Text(
                            value >= 1000
                                ? '${(value ~/ 1000)}k'
                                : value.toInt().toString(),
                            style: AppStyles.styleRegular13.copyWith(
                              color: const Color(0xff999999),
                              fontSize: 11,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() < 0 ||
                            value.toInt() >= weekLabels.length) {
                          return const SizedBox.shrink();
                        }
                        return SideTitleWidget(
                          meta: meta,
                          space: 8.0,
                          child: Text(
                            weekLabels[value.toInt()],
                            style: AppStyles.styleRegular13.copyWith(
                              color: const Color(0xff999999),
                              fontSize: 11,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(
                  show: false, // ✅ no border for chart area
                ),
                minX: 0,
                maxX: (spots.length - 1).toDouble(),
                minY: minY,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: lineGradientColors,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: areaGradientColors,
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
