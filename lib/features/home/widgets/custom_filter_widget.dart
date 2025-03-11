import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';

class CustomFilterWidget extends StatelessWidget {
  const CustomFilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Color(0xff5EDA42), borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: SvgPicture.asset(
            Assets.imagesFilter,
            height: 20,
          ),
        ),
      ),
    );
  }
}
