import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class AddIteamWidget extends StatelessWidget {
  const AddIteamWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff5EDA42)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset(Assets.imagesPlus),
          SizedBox(
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
    );
  }
}
