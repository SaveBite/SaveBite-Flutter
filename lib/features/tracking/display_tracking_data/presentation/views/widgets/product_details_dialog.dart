import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/entity/tracking_product_entity.dart';

class ProductDetailsDialog extends StatelessWidget {
  final TrackingProductEntity product;

  const ProductDetailsDialog({super.key, required this.product});

  static final labelStyle = AppStyles.styleMedium13.copyWith(
    fontWeight: FontWeight.w600,
    color: Color(0xff4D4D4D),
    fontSize: 14,
  );

  static final valueStyle = AppStyles.styleMedium13.copyWith(
    color: Color(0xff999999),
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    final String formattedStartDate =
        DateFormat('dd MMM, yyyy').format(product.startDate);
    final String formattedEndDate =
        DateFormat('dd MMM, yyyy').format(product.endDate);

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(Assets.imagesTrackingViewDetailsDart),
                Text(
                  product.name,
                  style: AppStyles.styleBold19.copyWith(
                    color: Color(0xff333333),
                    fontSize: 17,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 32),
            buildInfoRow('ID No:', product.numberId),
            buildInfoRow('Product Name:', product.name),
            buildInfoRow('Category:', product.category),
            buildInfoRow('Start Date:', formattedStartDate),
            buildInfoRow('End Date:', formattedEndDate),
            buildInfoRow('Quantity:', product.quantity.toString()),
            buildInfoRow('Status:', product.status),
            buildInfoRow('Label:', product.label),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: labelStyle),
            const SizedBox(
              width: 32,
            ),
            Text(value, style: valueStyle),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(
          height: 1,
          color: Color(0xffF2F2F2),
          thickness: 1,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
