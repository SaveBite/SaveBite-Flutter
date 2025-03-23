import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class MoreIcon extends StatelessWidget {
  const MoreIcon(
      {super.key, required this.currentIndex, required this.itemIndex});
  final int currentIndex, itemIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            Assets.imagesMore,
            colorFilter: ColorFilter.mode(
              currentIndex == itemIndex ? Color(0xFF5EDA42) : Color(0xffB3B3B3),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            'More',
            style: AppStyles.styleMedium10.copyWith(
              color: currentIndex == itemIndex
                  ? Color(0xFF5EDA42)
                  : Color(0xffB3B3B3),
            ),
          ),
        ],
      ),
    );
  }
}
