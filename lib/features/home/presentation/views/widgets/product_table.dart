import 'package:flutter/material.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/home/data/models/product_model.dart';
import 'package:save_bite/features/home/presentation/views/widgets/product_name_header.dart';
import 'package:save_bite/features/home/presentation/views/widgets/tabler_header_iteam.dart';

class ProductTable extends StatefulWidget {
  const ProductTable({super.key, required this.products});
  final List<ProductModel> products;

  @override
  State<ProductTable> createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 0,
      horizontalMargin: 0,
      border: TableBorder.all(
        borderRadius: BorderRadius.circular(4),
        color: Color(0xffE2E1E1),
        width: 0,
      ),
      dataTextStyle: AppStyles.styleRegular16.copyWith(
        color: Color(0xff1A1A1A),
        fontSize: 14,
      ),
      dividerThickness: 0,
      columns: [
        DataColumn(label: TableHeaderIteam(iteamName: "Date")),
        DataColumn(label: ProductNameHeader()),
        DataColumn(label: TableHeaderIteam(iteamName: "Category")),
        DataColumn(label: TableHeaderIteam(iteamName: "UnitPrice")),
        DataColumn(label: TableHeaderIteam(iteamName: "StockQuantity")),
        DataColumn(label: TableHeaderIteam(iteamName: "ReorderLevel")),
        DataColumn(label: TableHeaderIteam(iteamName: "ReorderQuantity")),
        DataColumn(label: TableHeaderIteam(iteamName: "UnitsSold")),
        DataColumn(label: TableHeaderIteam(iteamName: "SalesValue")),
      ],
      rows: widget.products
          .map((product) => DataRow(
                cells: [
                  DataCell(
                    Container(
                      color: Colors.white,
                      width: 166,
                      height: 55,
                      margin: EdgeInsets.only(
                        right: 0,
                        bottom: 2,
                      ),
                      padding: EdgeInsets.only(left: 12), // هامش أيسر بمقدار 8
                      alignment: Alignment.centerLeft,
                      child: Text(product.date),
                    ),
                  ),
                  DataCell(
                    Container(
                      color: Colors.white,
                      width: 400,
                      height: 55,
                      padding: EdgeInsets.only(left: 12),
                      margin: EdgeInsets.only(
                        right: 0,
                        bottom: 2,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        product.productName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      color: Colors.white,
                      width: 166,
                      height: 55,
                      padding: EdgeInsets.only(left: 12),
                      margin: EdgeInsets.only(
                        right: 0,
                        bottom: 2,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(product.category),
                    ),
                  ),
                  DataCell(
                    Container(
                      color: Colors.white,
                      width: 166,
                      height: 55,
                      padding: EdgeInsets.only(left: 12),
                      margin: EdgeInsets.only(
                        right: 0,
                        bottom: 2,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(product.unitPrice.toString()),
                    ),
                  ),
                  DataCell(
                    Container(
                      color: Colors.white,
                      width: 166,
                      height: 55,
                      padding: EdgeInsets.only(left: 12),
                      margin: EdgeInsets.only(
                        right: 0,
                        bottom: 2,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(product.stockQuantity.toString()),
                    ),
                  ),
                  DataCell(
                    Container(
                      color: Colors.white,
                      width: 166,
                      height: 55,
                      padding: EdgeInsets.only(left: 12),
                      margin: EdgeInsets.only(
                        right: 0,
                        bottom: 2,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(product.reorderLevel.toString()),
                    ),
                  ),
                  DataCell(
                    Container(
                      color: Colors.white,
                      width: 166,
                      height: 55,
                      padding: EdgeInsets.only(left: 12),
                      margin: EdgeInsets.only(
                        right: 0,
                        bottom: 2,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(product.reorderQuantity.toString()),
                    ),
                  ),
                  DataCell(
                    Container(
                      color: Colors.white,
                      width: 166,
                      height: 55,
                      padding: EdgeInsets.only(left: 12),
                      margin: EdgeInsets.only(
                        right: 0,
                        bottom: 2,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(product.unitsSold.toString()),
                    ),
                  ),
                  DataCell(
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(
                        right: 0,
                        bottom: 2,
                      ),
                      width: 166,
                      height: 55,
                      padding: EdgeInsets.only(left: 12),
                      alignment: Alignment.centerLeft,
                      child: Text(product.salesValue.toString()),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
