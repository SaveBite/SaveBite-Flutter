import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/utils/app_assets.dart';
import 'filter_drawer.dart'; // <-- Make sure this import exists

Widget buildHeaderSection(
    BuildContext context,
    String startDate,
    String endDate,
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.calendar_month),
          label: Text(
            '$startDate - $endDate',
            style: const TextStyle(color: Color(0xff999999)),
          ),
          style: ElevatedButton.styleFrom(
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

        // Filter icon
        InkWell(
          onTap: () {
            print("🎯 Filter button tapped");
          },
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
