import 'package:flutter/material.dart';
import 'package:save_bite/features/home/presentation/views/widgets/tabler_header_iteam.dart';

class TablerHeaderListView extends StatefulWidget {
  const TablerHeaderListView({super.key});

  @override
  State<TablerHeaderListView> createState() => _TablerHeaderListViewState();
}

class _TablerHeaderListViewState extends State<TablerHeaderListView> {
  List<String> iteamsNames = [
    'Date',
    'Product Name',
    'Category',
    'Price',
    'Quantity',
    'Reorder Level',
    'Reorder Quantity',
    'Units Sold',
    'Sales Value',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 59,
      child: ListView.builder(
        itemCount: iteamsNames.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              right: 1,
            ),
            child: TableHeaderIteam(
              iteamName: iteamsNames[index],
            ),
          );
        },
      ),
    );
  }
}
