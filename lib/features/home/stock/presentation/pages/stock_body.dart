import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:save_bite/features/home/stock/presentation/widgets/line_chart.dart';

import '../../../../../core/widgets/loading_widget.dart';
import '../../domain/entites/product_filter_entity.dart';
import '../bloc/stock_bloc.dart';
import '../widgets/data_table.dart';
import '../widgets/filter_drawer.dart';
import '../widgets/search_bar.dart';

class StockViewBody extends StatefulWidget {
  final VoidCallback onFilterOpened;
  final VoidCallback onFilterClosed;

  const StockViewBody({
    super.key,
    required this.onFilterOpened,
    required this.onFilterClosed,
  });

  @override
  State<StockViewBody> createState() => _StockViewBodyState();
}

class _StockViewBodyState extends State<StockViewBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.read<StockBloc>().add(GetStockProductsEvent(
          filter: ProductFilterEntity(),
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime date) {
      return DateFormat('d MMM').format(date);
    }

    /// 💡 Safely map one product's quantities to FlSpot
    List<FlSpot> mapToFlSpots(List<int> quantities) {
      return quantities.asMap().entries.map((entry) {
        return FlSpot(
          entry.key.toDouble(),
          entry.value.toDouble(),
        );
      }).toList();
    }

    return BlocListener<StockBloc, StockState>(
      listener: (context, state) {
        print("🌀 StockBloc State Changed: $state");
      },
      child: BlocBuilder<StockBloc, StockState>(
        builder: (context, state) {
          if (state is StockLoading) {
            return const Center(child: LoadingWidget());
          } else if (state is StockLoaded) {

            final stockItems = state.stockData;
            for (var item in stockItems.data) {
              print(
                  "Product: ${item.productName}, Reorder Quantities: ${item.reorderQuantities}");
            }
            if (stockItems.data.isEmpty) {
              return const Center(child: Text("No items in stock."));
            }

            return Scaffold(
              backgroundColor: const Color(0xffF2F2F2),
              key: _scaffoldKey,
              endDrawer: FilterDrawer(
                onClose: widget.onFilterClosed,
                stockData: stockItems,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        toolbarHeight: 50,
                        backgroundColor: const Color(0xffFFFFFF),
                        elevation: 0,
                        centerTitle: true,
                        title: Text(
                          "Stock",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Container(
                        color: const Color(0xFFFFFFFF),
                        child: Column(
                          children: [
                            const Divider(
                                color: Color(0xffCCCCCC), height: 0.5),
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton.icon(
                                    icon: const Icon(Icons.calendar_month),
                                    label: Text(
                                      '${formatDate(stockItems.startDate)} - ${formatDate(stockItems.endDate)}',
                                      style: const TextStyle(
                                          color: Color(0xff999999)),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      iconColor: const Color(0xff999999),
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        side: const BorderSide(
                                          color: Color(0xffE6E6E5),
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      // TODO: Implement date picker logic
                                    },
                                  ),
                                  InkWell(
                                    onTap: () {
                                      widget.onFilterOpened();
                                      _scaffoldKey.currentState!
                                          .openEndDrawer();
                                    },
                                    child: const Icon(
                                      Icons.tune,
                                      size: 30,
                                      color: Color(0xFF5EDA42),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),

                            // StockChartWithTooltip()

                            // 👇 You can now safely pass average or custom curve
                            buildLineChart(
                              // curve1: mapAverageCurve(stockItems.data),
                              curve1: mapToFlSpots(
                                  stockItems.data[0].reorderQuantities),
                              curve2: mapToFlSpots(
                                  stockItems.data[1].reorderQuantities),
                              curve3: mapToFlSpots(
                                  stockItems.data[6].reorderQuantities),
                              curve4: mapToFlSpots(
                                  stockItems.data[10].reorderQuantities),
                              productNames: [
                                stockItems.data[0].productName,
                                stockItems.data[1].productName,
                                stockItems.data[6].productName,
                                stockItems.data[10].productName,

                              ],
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
                      ),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: buildDataTable(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is StockError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: Text("No state yet"));
        },
      ),
    );
  }
}
