import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class CustomBottomNavigationBarIteam extends StatelessWidget {
  const CustomBottomNavigationBarIteam({
    super.key,
    required this.currentIndex,
    required this.image,
    required this.title,
    required this.itemIndex,
  });

  final int currentIndex;
  final int itemIndex;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            height: 28,
            width: 28,
            image,
            colorFilter: ColorFilter.mode(
              currentIndex == itemIndex ? Color(0xFF5EDA42) : Color(0xffB3B3B3),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            title,
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
