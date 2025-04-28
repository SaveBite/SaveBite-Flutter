import 'package:flutter/material.dart';
import 'package:save_bite/features/stock/presentation/widgets/search_bar.dart';
import '../../domain/entites/product_stock_response_entity.dart';
import 'filter_category_section.dart';

class FilterDrawer extends StatefulWidget {
  final VoidCallback? onClose;
  final ProductStockResponseEntity stockData;
  final Function(Set<String>)? onApplyFilter;

  const FilterDrawer({
    super.key,
    this.onClose,
    required this.stockData,
    this.onApplyFilter,
  });
  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  bool isAnySelected = false;
  String searchTerm = "";
  final GlobalKey<FilterCategoryCheckboxState> _checkboxKey = GlobalKey();

  void _onSelectionChanged(bool anySelected) {
    setState(() {
      isAnySelected = anySelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text("Filter",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () {
                      Navigator.pop(context);
                      if (widget.onClose != null) widget.onClose!();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "Select the filter according to what you want.",
                style: TextStyle(
                    color: Color(0xffB3B3B3),
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 16),
              buildSearchBar(
                Colors.transparent, 0, 0, 14, "Search Product Name or Category",
                onChanged: (value) {
                  setState(() {
                    searchTerm = value.toLowerCase();
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text("Category",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black)),
              const SizedBox(height: 12),
              Expanded(
                  child: FilterCategoryCheckbox(
                      key: _checkboxKey,
                      stockData: widget.stockData,
                      onSelectionChanged: _onSelectionChanged,
                      searchTerm : searchTerm
                  )),


              // TODO : apply on the chart
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Get selected product names
                    final selectedProducts =
                        _checkboxKey.currentState?.getSelectedProductNames() ?? {};
                    // Call callback with selected products
                    widget.onApplyFilter?.call(selectedProducts);

                    Navigator.pop(context);
                    if (widget.onClose != null) widget.onClose!();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    isAnySelected ? const Color(0xFF5EDA42) : Colors.grey,
                    minimumSize: const Size(220,48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Apply filter",
                      style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}