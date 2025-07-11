import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/stock_bloc.dart';
import '../../domain/entites/product_filter_entity.dart';
import 'stock_body.dart';
import '../widgets/filter_drawer.dart';
import '../../../../../core/widgets/loading_widget.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  Set<String> selectedProductNames = {};
  String searchText = '';

  @override
  void initState() {
    super.initState();
    context.read<StockBloc>().add(GetStockProductsEvent(
      filter: ProductFilterEntity(),
    ));
  }

  void _openFilter() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: FractionallySizedBox(
            widthFactor: 0.75,
            heightFactor: 1.0,
            child: BlocBuilder<StockBloc, StockState>(
              builder: (context, state) {
                if (state is StockLoaded) {
                  return FilterDrawer(
                    onClose: () => Navigator.of(context).pop(),
                    stockData: state.stockData,
                    onApplyFilter: _applyFilter,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  void _applyFilter(Set<String> selectedProducts) {
    setState(() {
      selectedProductNames = selectedProducts;
      print("Selected Products: $selectedProductNames");
    });
  }

  void _resetFilter() {
    setState(() {
      selectedProductNames = {};
      print("Filter Reset: selectedProductNames cleared");
    });
  }

  void _onSearchChanged(String text) {
    setState(() {
      searchText = text;
      print("Search Text: $searchText");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockBloc, StockState>(
      builder: (context, state) {
        if (state is StockLoading) {
          return const Center(child: LoadingWidget());
        }
        // else if (state is StockLoaded) {
        //   return SafeArea(
        //     child: Scaffold(
        //       backgroundColor: const Color(0xffF2F2F2),
        //       body: StockViewBody(
        //         onFilterOpened: _openFilter,
        //         onFilterClosed: () {},
        //         onResetFilter: _resetFilter,
        //         stockData: state.stockData,
        //         selectedProductNames: selectedProductNames,
        //         searchText: searchText,
        //         onSearchChanged: _onSearchChanged,
        //       ),
        //     ),
        //   );
        // }
        else if (state is StockLoaded) {
          if (state.stockData.data.isEmpty) {
            return const Center(
              child: Text(
                "No stock data found. Please upload a valid CSV.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            );
          }

          return SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xffF2F2F2),
              body: StockViewBody(
                onFilterOpened: _openFilter,
                onFilterClosed: () {},
                onResetFilter: _resetFilter,
                stockData: state.stockData,
                selectedProductNames: selectedProductNames,
                searchText: searchText,
                onSearchChanged: _onSearchChanged,
              ),
            ),
          );
        }



        else if (state is StockError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );        }
        return const SizedBox.shrink();
      },
    );
  }
}