import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:save_bite/features/analytics/domain/entity/sales_data_entity.dart';

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
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          border:
              Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: const Center(
          child: Text('No sales data available to display chart.'),
        ),
      );
    }

    List<FlSpot> spots = [];
    List<String> weekLabels = [];

    double minSales = salesData.weeklySales
        .map((e) => e.salesPredictions)
        .reduce((a, b) => a < b ? a : b)
        .toDouble();
    double maxSales = salesData.weeklySales
        .map((e) => e.salesPredictions)
        .reduce((a, b) => a > b ? a : b)
        .toDouble();

    double minY = (minSales * 0.8).floorToDouble();
    double maxY = (maxSales * 1.2).ceilToDouble();
    if (minY < 0) minY = 0;

    const double interval = 2000;
    maxY = (maxY / interval).ceil() * interval;
    minY = (minY / interval).floor() * interval;
    if (minY < 0) minY = 0;

    for (int i = 0; i < salesData.weeklySales.length; i++) {
      final weeklySale = salesData.weeklySales[i];
      spots.add(FlSpot(i.toDouble(), weeklySale.salesPredictions.toDouble()));
      weekLabels.add('Week ${i + 1}');
    }

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
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        border: Border.all(
          color: Colors.blueAccent.withOpacity(0.5),
          width: 1.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sales Analytics',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
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
                  const Icon(Icons.calendar_today,
                      size: 18, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    dateRangeText,
                    style: TextStyle(color: Colors.grey.shade700),
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
                  drawVerticalLine: true,
                  horizontalInterval: interval / 2,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) => const FlLine(
                    color: Color(0xfff3f3f3),
                    strokeWidth: 1,
                  ),
                  getDrawingVerticalLine: (value) => const FlLine(
                    color: Color(0xfff3f3f3),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 60,
                      interval: interval,
                      getTitlesWidget: (value, meta) {
                        if (value % interval != 0)
                          return const SizedBox.shrink();
                        return SideTitleWidget(
                          meta: meta,
                          space: 8,
                          child: Text(
                            '${(value ~/ 1000)}k',
                            // 👇 You can edit Y axis style here
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
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
                            // 👇 You can edit X axis style here
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
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
                  show: true,
                  border: Border.all(color: const Color(0xff37434d), width: 1),
                ),
                minX: 0,
                maxX: (salesData.weeklySales.length - 1).toDouble(),
                minY: minY - interval / 2,
                maxY: maxY + interval / 2,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: false, // 👈 ZIGZAG line
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
