import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // استيراد BlocProvider
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/home/presentation/manger/products_cubit/products_cubit.dart'; // استيراد ProductsCubit
import 'package:save_bite/features/home/presentation/views/widgets/add_iteam_bottom_sheet.dart';

class AddIteamWidget extends StatelessWidget {
  const AddIteamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // استرجاع ProductsCubit من السياق الحالي
    final productsCubit = BlocProvider.of<ProductsCubit>(context);

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            // توفير ProductsCubit هنا
            return BlocProvider.value(
              value: productsCubit, // تمرير ProductsCubit المسترجع
              child: AddIteamBottomSheet(),
            );
          },
        );
      },
      splashColor: Colors.green[100],
      highlightColor: Colors.green[200],
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff5EDA42)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SvgPicture.asset(Assets.imagesPlus),
            const SizedBox(
              width: 4,
            ),
            Text(
              'Add Iteam',
              style: AppStyles.styleRegular13.copyWith(
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
