import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/entity/tracking_product_entity.dart';
import 'package:save_bite/features/tracking/display_tracking_data/presentation/manger/tarcking_cubit/tracking_cubit.dart';
import 'package:save_bite/features/tracking/display_tracking_data/presentation/views/widgets/delete_product_dialog.dart';

class DotTrackingTableWidget extends StatelessWidget {
  final TrackingProductEntity product;

  const DotTrackingTableWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTapDown: (details) async {
            final RenderBox overlay =
                Overlay.of(context).context.findRenderObject() as RenderBox;

            final result = await showMenu(
              context: context,
              position: RelativeRect.fromRect(
                details.globalPosition & const Size(40, 40),
                Offset.zero & overlay.size,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              items: [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      SvgPicture.asset(Assets.imagesEditTracking),
                      const SizedBox(width: 8),
                      Text(
                        "Edit",
                        style: AppStyles.styleRegular16.copyWith(
                          color: const Color(0xff1A1A1A),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      SvgPicture.asset(Assets.imagesDeleteTracking),
                      const SizedBox(width: 8),
                      Text(
                        "Delete",
                        style: AppStyles.styleRegular16.copyWith(
                          color: const Color(0xffFF3333),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );

            if (result == 'edit') {
              // TODO: Handle edit action
            } else if (result == 'delete') {
              showDialog(
                context: context,
                builder: (_) => DeleteProductDialog(
                  product: product,
                  onDelete: () {
                    BlocProvider.of<TrackingCubit>(context)
                        .deleteTrackingProduct(product.id);
                  },
                ),
              );
            }
          },
          child: SvgPicture.asset(
            Assets.imagesTrackingDotButton,
          ),
        );
      },
    );
  }
}
