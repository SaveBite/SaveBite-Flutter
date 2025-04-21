import 'package:flutter/material.dart';

Widget buildDataTable() {
  final products = [
    {'name': 'Milk', 'category': 'Dairy', 'reorderQty': 50},
    {'name': 'Apples', 'category': 'Produce', 'reorderQty': 50},
    {'name': 'Rice', 'category': 'Grains', 'reorderQty': 60},
  ];

  return DataTable(
    columns: [
      DataColumn(label: Text('Product Name')),
      const DataColumn(label: Text('Category')),
      const DataColumn(label: Text('Reorder Quantity')),
    ],
    rows: products.map((product) {
      return DataRow(cells: [
        DataCell(Text(product['name'].toString())),
        DataCell(Text(product['category'].toString())),
        DataCell(Text(product['reorderQty'].toString())),
      ]);
    }).toList(),
  );
}
