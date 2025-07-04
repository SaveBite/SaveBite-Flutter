import 'package:flutter/material.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class CoomunityHeader extends StatelessWidget {
  const CoomunityHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Your Recent Campaigns',
          style: AppStyles.styleMedium16.copyWith(
            color: Color(0xff1A1A1A),
            fontSize: 15,
          ),
        ),
        Spacer(),
        Text(
          'View all',
          style: AppStyles.styleMedium13.copyWith(
            color: Color(0xff5EDA42),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
