import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_assets.dart';

Widget buildHeaderSection(
    BuildContext context,
    String startDate,
    String endDate,
    List<String> productNames, // List of product names for the chart
    Set<String> selectedProductNames, // Add selectedProductNames
    VoidCallback onFilterTapped,
    VoidCallback onResetFilter,
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.calendar_month),
          label: Text(
            '$startDate - $endDate',
            style: const TextStyle(color: Color(0xff999999)),
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(72, 36),
            elevation: 0,
            iconColor: const Color(0xff999999),
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(color: Color(0xffE6E6E5), width: 1.5),
            ),
          ),
          onPressed: () {
            // Implement date range filter if needed
          },
        ),

        Spacer(),
        if (selectedProductNames.isNotEmpty) // Conditionally include reset button
          ElevatedButton.icon(
            onPressed: onResetFilter,
            label: Text(
              selectedProductNames.length == 1
                  ? selectedProductNames.first.split(" ").first
                  : '${selectedProductNames.length} selected',
              style: const TextStyle(
                color: Color(0xFF5EDA42),
                fontSize: 12,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffEDFBEA),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: const Size(72, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            icon: const Icon(
              Icons.cancel_outlined,
              color: Color(0xffDE4B4B),
              size: 16,
            ),
            iconAlignment: IconAlignment.end,
          ),
        const SizedBox(width: 8),
        InkWell(
          onTap: onFilterTapped,
          child: SvgPicture.asset(
            Assets.imagesTuneFilter,
            width: 35,
            height: 35,
            color: const Color(0xFF5EDA42),
          ),
        ),
      ],
    ),
  );
}