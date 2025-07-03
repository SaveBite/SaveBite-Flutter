import 'package:flutter/material.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class TrackingTableHeader extends StatelessWidget {
  const TrackingTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            'ID No.',
            style: AppStyles.styleMedium16.copyWith(
              color: const Color(0xffB3B3B3),
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 35),
          Text(
            'Product',
            style: AppStyles.styleMedium16.copyWith(
              color: const Color(0xffB3B3B3),
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 90),
          Text(
            'status',
            style: AppStyles.styleMedium16.copyWith(
              color: const Color(0xffB3B3B3),
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 70),
          Text(
            'Quantity',
            style: AppStyles.styleMedium16.copyWith(
              color: const Color(0xffB3B3B3),
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 60),
          Text(
            'Start Date',
            style: AppStyles.styleMedium16.copyWith(
              color: const Color(0xffB3B3B3),
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 60),
          Text(
            'End Date',
            style: AppStyles.styleMedium16.copyWith(
              color: const Color(0xffB3B3B3),
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 80),
          Text(
            'Details',
            style: AppStyles.styleMedium16.copyWith(
              color: const Color(0xffB3B3B3),
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 60),
          Text(
            'Actions',
            style: AppStyles.styleMedium16.copyWith(
              color: const Color(0xffB3B3B3),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
