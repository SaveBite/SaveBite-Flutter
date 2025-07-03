import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class TrackingAllertWidget extends StatelessWidget {
  const TrackingAllertWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(
        vertical: 25,
      ),
      padding: EdgeInsets.only(
        left: 10,
        right: 14,
        top: 24,
        bottom: 24,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffEDFBEA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset(Assets.imagesI),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add the items you’ve recently ',
                style: AppStyles.styleRegular16.copyWith(
                  color: Color(0xff1A1A1A),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'bought to keep track of when  ',
                style: AppStyles.styleRegular16.copyWith(
                  color: Color(0xff1A1A1A),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'they expire, This helps you ',
                style: AppStyles.styleRegular16.copyWith(
                  color: Color(0xff1A1A1A),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'reduce food waste, save money,',
                style: AppStyles.styleRegular16.copyWith(
                  color: Color(0xff1A1A1A),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'and plan smarter meals.',
                style: AppStyles.styleRegular16.copyWith(
                  color: Color(0xff1A1A1A),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(Assets.imagesX),
          ),
        ],
      ),
    );
  }
}
