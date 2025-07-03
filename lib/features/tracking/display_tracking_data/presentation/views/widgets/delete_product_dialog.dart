import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/entity/tracking_product_entity.dart';

class DeleteProductDialog extends StatelessWidget {
  final TrackingProductEntity product;
  final VoidCallback onDelete;

  const DeleteProductDialog({
    super.key,
    required this.product,
    required this.onDelete,
  });

  static final labelStyle = AppStyles.styleMedium13.copyWith(
    fontWeight: FontWeight.w600,
    color: const Color(0xff4D4D4D),
    fontSize: 14,
  );

  static final valueStyle = AppStyles.styleMedium13.copyWith(
    color: const Color(0xff999999),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(Assets.imagesDeleteTrackingProduct),
                Text(
                  'Delete',
                  style: AppStyles.styleBold19.copyWith(
                    fontSize: 17,
                    color: const Color(0xffFF3333),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Are you sure you want to delete this item?',
              style: AppStyles.styleBold16.copyWith(
                color: Color(0xff333333),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            buildInfoRow('ID No:', product.numberId),
            buildInfoRow('Product Name:', product.name),
            buildInfoRow('Category:', product.category),
            buildInfoRow('Start Date:', formattedStartDate),
            buildInfoRow('End Date:', formattedEndDate),
            buildInfoRow('Quantity:', product.quantity.toString()),
            buildInfoRow('Status:', product.status),
            buildInfoRow('Label:', product.label),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: 47,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffF6F6F6),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: AppStyles.styleBold19.copyWith(
                          color: Color(0xff666666),
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 47,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      onDelete();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFF3333),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            )
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
            const SizedBox(width: 32),
            Expanded(child: Text(value, style: valueStyle)),
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
