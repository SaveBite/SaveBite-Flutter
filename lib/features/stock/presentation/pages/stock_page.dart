// stock_page.dart

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Set<String> selectedProductNames = {};

  @override
  void initState() {
    super.initState();
    context.read<StockBloc>().add(GetStockProductsEvent(
      filter: ProductFilterEntity(),
    ));
  }

  void _openFilter() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _closeFilter() {
    Navigator.of(context).maybePop(); // Closes the drawer if open
  }

  void _applyFilter(Set<String> selectedProducts) {
    setState(() {
      selectedProductNames = selectedProducts;
      print("Selected Products: $selectedProductNames");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockBloc, StockState>(
      builder: (context, state) {
        if (state is StockLoading) {
          return const Center(child: LoadingWidget());
        } else if (state is StockLoaded) {
          print("Building StockPage with selectedProductNames: $selectedProductNames");
          return Scaffold(
            backgroundColor: const Color(0xffF2F2F2),
            key: _scaffoldKey,
            endDrawer: FilterDrawer(
              onClose: _closeFilter,
              stockData: state.stockData,
              onApplyFilter: _applyFilter,
            ),
            body: StockViewBody(
              onFilterOpened: _openFilter,
              onFilterClosed: _closeFilter,
              stockData: state.stockData,
              selectedProductNames: selectedProductNames,
            ),
          );
        } else if (state is StockError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}