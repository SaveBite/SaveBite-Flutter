import 'package:flutter/material.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/home/presentation/views/widgets/tabler_header_iteam.dart';

import '../../../home/presentation/views/widgets/product_name_header.dart';
import '../../data/models/product_stock_response_model.dart';
import '../../domain/entites/product_stock_response_entity.dart';

class StockTable extends StatefulWidget {
  const StockTable({super.key, required this.products});

  final List<DatumEntity> products;

  @override
  State<StockTable> createState() => _ProductTableState();
}

class _ProductTableState extends State<StockTable> {
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
        // DataColumn(label: TableHeaderIteam(iteamName: "Product Name")),
        DataColumn(label: ProductNameHeader()),
        DataColumn(label: TableHeaderIteam(iteamName: "Category")),
        DataColumn(label: TableHeaderIteam(iteamName: "ReorderQuantity ")),
        // DataColumn(label: TableHeaderIteam(iteamName: "ReorderQuantity Week2")),
        // DataColumn(label: TableHeaderIteam(iteamName: "ReorderQuantity Week3")),
        // DataColumn(label: TableHeaderIteam(iteamName: "ReorderQuantity Week4")),
        // DataColumn(label: SizedBox()),
        // DataColumn(label: SizedBox()),
        // DataColumn(label: SizedBox()),

      ],
      rows: widget.products
          .map((product) => DataRow(
                cells: [
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
                        child: Text(product.reorderQuantities.toString().replaceAll("[", "").replaceAll("]", "").replaceAll(", ", "      "))
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
