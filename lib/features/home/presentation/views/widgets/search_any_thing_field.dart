import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class SearchAnyThingField extends StatelessWidget {
  const SearchAnyThingField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white60,
      ),
      child: Row(
        children: [
          SvgPicture.asset(Assets.imagesSearch),
          SizedBox(
            width: 8,
          ),
          Text(
            'Search anything',
            style: AppStyles.styleRegular16,
          ),
        ],
      ),
    );
  }
}
