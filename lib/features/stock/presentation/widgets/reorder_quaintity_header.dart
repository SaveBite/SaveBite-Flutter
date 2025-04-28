import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class ReorderQuaintityHeader extends StatelessWidget {
  const ReorderQuaintityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
      ),
      height: 55,
      width: 275,
      decoration: BoxDecoration(
          color: Color(0xffF8FFF6),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Color(0xffEDE4E4))),
      child: Row(
        children: [
          Text(
            'Reorder Quaintity',
            style: AppStyles.styleMedium16.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Spacer(),
          SvgPicture.asset(Assets.imagesTapleHeaderIcon)
        ],
      ),
    );
  }
}
