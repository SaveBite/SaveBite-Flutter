import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class TableHeaderIteam extends StatelessWidget {
  const TableHeaderIteam({
    super.key,
    required this.iteamName,
  });
  final String iteamName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
      ),
      height: 55,
      width: 167,
      decoration: BoxDecoration(
          color: Color(0xffF8FFF6),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Color(0xffEDE4E4))),
      child: Row(
        children: [
          Text(
            iteamName,
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
