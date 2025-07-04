import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';

import '../../../../../core/utils/app_styles.dart';

class ExploreSection extends StatelessWidget {
  const ExploreSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Explore',
          style: AppStyles.styleMedium16.copyWith(
            color: Color(0xff1A1A1A),
            fontSize: 15,
          ),
        ),
        Spacer(),
        Container(
          height: 40,
          width: 144,
          padding: EdgeInsets.symmetric(
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(0xffEDE4E4),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.imagesCommunitySearch,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Search ... ',
                style: AppStyles.styleRegular16.copyWith(
                  color: Color(0xffCCCCCC),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Container(
          height: 40,
          width: 80,
          padding: EdgeInsets.symmetric(
            horizontal: 4,
          ),
          decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(0xffEDE4E4),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Text(
                'Filter',
                style: AppStyles.styleRegular16.copyWith(
                  color: Color(0xffCCCCCC),
                  fontSize: 15,
                ),
              ),
              SizedBox(
                width: 4,
              ),
              SvgPicture.asset(
                Assets.imagesCommunityFilter,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
