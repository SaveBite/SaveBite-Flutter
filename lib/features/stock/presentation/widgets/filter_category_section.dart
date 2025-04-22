import 'package:flutter/material.dart';
import '../../domain/entites/product_stock_response_entity.dart';

class FilterCategoryCheckbox extends StatefulWidget {
  final ProductStockResponseEntity stockData;
  final void Function(bool)? onSelectionChanged;
  final String searchTerm;

  const FilterCategoryCheckbox({
    super.key,
    required this.stockData,
    required this.onSelectionChanged,
    required this.searchTerm,
  });

  @override
  State<FilterCategoryCheckbox> createState() => _FilterCategoryCheckboxState();
}

class _FilterCategoryCheckboxState extends State<FilterCategoryCheckbox> {
  late Map<String, List<String>> groupedData;
  Map<String, bool> parentChecked = {};
  Map<String, Map<String, bool>> childChecked = {};
  Map<String, bool> isExpanded = {};

  @override
  void initState() {
    super.initState();
    _groupData(widget.stockData);
  }

  void _groupData(ProductStockResponseEntity stockData) {
    groupedData = {};
    for (var item in stockData.data) {
      groupedData.putIfAbsent(item.category, () => []).add(item.productName);
    }

    for (var category in groupedData.keys) {
      parentChecked[category] = false;
      isExpanded[category] = false;
      childChecked[category] = {
        for (var product in groupedData[category]!) product: false
      };
    }
  }

  void _toggleParent(String category, bool? value) {
    setState(() {
      parentChecked[category] = value!;
      childChecked[category] = {
        for (var product in groupedData[category]!) product: value
      };
    });
    widget.onSelectionChanged?.call(_checkAnySelected());

  }

  void _toggleChild(String category, String product, bool? value) {
    setState(() {
      childChecked[category]![product] = value!;
      parentChecked[category] = !childChecked[category]!.containsValue(false);
    });
    widget.onSelectionChanged?.call(_checkAnySelected());
  }

  bool _checkAnySelected() {
    for (var category in childChecked.values) {
      if (category.containsValue(true)) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Auto-expand matching categories if search is not empty
    if (widget.searchTerm.isNotEmpty) {
      for (var category in groupedData.keys) {
        final matchedProducts = groupedData[category]!
            .where((product) =>
        product.toLowerCase().contains(widget.searchTerm) ||
            category.toLowerCase().contains(widget.searchTerm))
            .toList();
        if (matchedProducts.isNotEmpty) {
          isExpanded[category] = true;
        }
      }
    }

    return ListView(
      children: groupedData.keys.map((category) {
        final matchedProducts = groupedData[category]!
            .where((product) =>
        product.toLowerCase().contains(widget.searchTerm) ||
            category.toLowerCase().contains(widget.searchTerm))
            .toList();

        final shouldShow =
            widget.searchTerm.isEmpty || matchedProducts.isNotEmpty;

        if (!shouldShow) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(left: 0),
              leading: Checkbox(
                value: parentChecked[category],

                //TODO :
                onChanged: (val) {
                  _toggleParent(category, val);
                  isExpanded[category] = true;
                },
                side: const BorderSide(color: Color(0xffB3B3B3), width: 1),
                activeColor: const Color(0xff5EDA42),
              ),
              title: Text(
                category,
                style: const TextStyle(
                  color: Color(0xff666666),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  isExpanded[category] == true
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xff666666),
                ),
                onPressed: () {
                  setState(() {
                    isExpanded[category] = !(isExpanded[category] ?? false);
                  });
                },
              ),
              onTap: () {
                setState(() {
                  isExpanded[category] = !(isExpanded[category] ?? false);
                });
              },
            ),
            if ((isExpanded[category] ?? false) == true)
              ...(widget.searchTerm.isEmpty
                  ? groupedData[category]!
                  : matchedProducts)
                  .map((product) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: CheckboxListTile(
                    title: Text(
                      product,
                      style: const TextStyle(
                        color: Color(0xff666666),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    value: childChecked[category]![product],
                    onChanged: (val) => _toggleChild(category, product, val),
                    controlAffinity: ListTileControlAffinity.leading,
                    side:
                    const BorderSide(color: Color(0xffB3B3B3), width: 1),
                    contentPadding: const EdgeInsets.only(left: 0),
                    activeColor: const Color(0xff5EDA42),
                  ),
                );
              }).toList(),
          ],
        );
      }).toList(),
    );
  }
}
