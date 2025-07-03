import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/entity/tracking_product_entity.dart';
import 'package:save_bite/features/tracking/display_tracking_data/presentation/views/widgets/dot_tracking_table_widget.dart';
import 'package:save_bite/features/tracking/display_tracking_data/presentation/views/widgets/product_details_dialog.dart';
import 'package:save_bite/features/tracking/display_tracking_data/presentation/views/widgets/tracking_taple_header.dart';
import 'package:save_bite/features/tracking/display_tracking_data/presentation/views/widgets/view_details_button.dart';

class TrackingTaple extends StatefulWidget {
  final List<TrackingProductEntity> items;

  const TrackingTaple({super.key, required this.items});

  @override
  State<TrackingTaple> createState() => _TrackingTapleState();
}

class _TrackingTapleState extends State<TrackingTaple> {
  int currentPage = 0;
  final int itemsPerPage = 7;

  Color getStatusColor(String status) {
    switch (status) {
      case 'in-date':
        return const Color(0xffD9F3E4);
      case 'near-to-expire':
        return const Color(0xffFFF7DD);
      case 'expired':
        return const Color(0xffFFDCDC);
      default:
        return Colors.black;
    }
  }

  Color getStatusTextColor(String status) {
    switch (status) {
      case 'in-date':
        return const Color(0xff3DA161);
      case 'near-to-expire':
        return const Color(0xffFECA1F);
      case 'expired':
        return const Color(0xffE14D4D);
      default:
        return Colors.black;
    }
  }

  Widget paddedText(String text, TextStyle style) {
    return SizedBox(width: 90, child: Text(text, style: style));
  }

  @override
  Widget build(BuildContext context) {
    final totalPages =
        (widget.items.length / itemsPerPage).ceil(); // total pages
    final startIndex = currentPage * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage > widget.items.length)
        ? widget.items.length
        : startIndex + itemsPerPage;
    final currentItems = widget.items.sublist(startIndex, endIndex);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TrackingTableHeader(),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: currentItems.map((item) {
                    final formattedStartDate =
                        DateFormat('dd MMM, yyyy').format(item.startDate);
                    final formattedEndDate =
                        DateFormat('dd MMM, yyyy').format(item.endDate);

                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        children: [
                          paddedText(
                            item.numberId,
                            AppStyles.styleBold16.copyWith(
                              color: const Color(0xffB3B3B3),
                              fontSize: 15,
                            ),
                          ),
                          paddedText(
                            item.name,
                            AppStyles.styleMedium16.copyWith(
                              color: const Color(0xff333333),
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            height: 27,
                            width: 131,
                            decoration: BoxDecoration(
                              color: getStatusColor(item.status),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                item.status.replaceAll('-', ' ').capitalize(),
                                style: AppStyles.styleRegular16.copyWith(
                                  color: getStatusTextColor(item.status),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 50),
                          paddedText(
                            item.quantity.toString(),
                            AppStyles.styleBold16.copyWith(
                              color: const Color(0xffB3B3B3),
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              formattedStartDate,
                              style: AppStyles.styleBold16.copyWith(
                                color: const Color(0xffB3B3B3),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          SizedBox(
                            width: 100,
                            child: Text(
                              formattedEndDate,
                              style: AppStyles.styleBold16.copyWith(
                                color: const Color(0xffB3B3B3),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          ViewDetailButton(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    ProductDetailsDialog(product: item),
                              );
                            },
                          ),
                          const SizedBox(width: 30),
                          DotTrackingTableWidget(product: item),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(
                  left: 110,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: currentPage > 0
                          ? () => setState(
                                () => currentPage--,
                              )
                          : null,
                      icon: const Icon(Icons.arrow_back_ios),
                      color: currentPage > 0 ? Colors.black : Colors.grey,
                      iconSize: 16,
                    ),
                    ...List.generate(totalPages, (index) {
                      final isActive = index == currentPage;
                      return GestureDetector(
                        onTap: () => setState(() => currentPage = index),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xff5EDA42)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: const Color(0xff5EDA42),
                            ),
                          ),
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                              color: isActive
                                  ? Colors.white
                                  : const Color(0xff5EDA42),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                    IconButton(
                      onPressed: currentPage < totalPages - 1
                          ? () => setState(() => currentPage++)
                          : null,
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: currentPage < totalPages - 1
                          ? Colors.black
                          : Colors.grey,
                      iconSize: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : this;
}
