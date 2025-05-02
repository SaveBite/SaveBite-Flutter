import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:save_bite/features/stock/presentation/widgets/stock_table.dart';
import '../../domain/entites/product_stock_response_entity.dart';
import '../widgets/header_selection.dart';
import '../widgets/line_chart.dart';
import '../widgets/search_bar.dart';

class StockViewBody extends StatelessWidget {
  final VoidCallback onFilterOpened;
  final VoidCallback onFilterClosed;
  final VoidCallback onResetFilter;
  final ProductStockResponseEntity stockData;
  final Set<String> selectedProductNames;
  final String searchText;
  final Function(String) onSearchChanged;

  const StockViewBody({
    super.key,
    required this.onFilterOpened,
    required this.onFilterClosed,
    required this.onResetFilter,
    required this.stockData,
    required this.selectedProductNames,
    required this.searchText,
    required this.onSearchChanged,
  });

  String formatDate(DateTime date) {
    return DateFormat('d MMM').format(date);
  }

  List<FlSpot> mapToFlSpots(List<int> quantities) {
    return quantities.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        entry.value.toDouble(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final stockItems = stockData;

    // Filter data based on selected product names
    final filteredChartData = selectedProductNames.isEmpty
        ? stockItems.data.take(4).toList()
        : stockItems.data
        .where((item) => selectedProductNames.contains(item.productName))
        .take(4)
        .toList();

    final filteredTableData = searchText.isEmpty
        ? stockItems.data
        : stockItems.data
        .where((item) => item.productName
        .toLowerCase()
        .contains(searchText.toLowerCase()))
        .toList();

    final productNames =
    filteredChartData.map((item) => item.productName).toList();
    final curves = filteredChartData
        .map((item) => mapToFlSpots(item.reorderQuantities))
        .toList();

    // Pad curves and productNames to ensure 4 curves are passed
    while (curves.length < 4) {
      curves.add([FlSpot(0, 0)]); // Empty curve
      productNames.add(""); // Empty name
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xFFFFFFFF),
              child: Column(
                children: [
                  const Divider(color: Color(0xffCCCCCC), height: 0.5),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Reorder Quantity",
                        style: const TextStyle(
                          color: Color(0xff5EDA42),
                          fontWeight: FontWeight.w700,
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  buildHeaderSection(
                    context,
                    formatDate(stockItems.startDate),
                    formatDate(stockItems.endDate),
                    productNames,
                    selectedProductNames, // Pass selectedProductNames
                    onFilterOpened,
                    onResetFilter,
                  ),
                  const SizedBox(height: 12),
                  buildLineChart(
                    curve1: curves[0],
                    curve2: curves[1],
                    curve3: curves[2],
                    curve4: curves[3],
                    productNames: productNames,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            buildSearchBar(
              const Color(0xFFFFFFFF),
              12,
              10,
              14,
              'Search Product Name',
              onChanged: onSearchChanged,
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StockTable(products: filteredTableData),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}