import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class SearchProductField extends StatelessWidget {
  const SearchProductField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.56,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 10, top: 40),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Transform.scale(
              scale: 0.5,
              child: SvgPicture.asset(
                Assets.imagesProductSearch,
              ),
            ),
          ),
          hintText:
              'Search product Name                                                                                               ',
          hintStyle: AppStyles.styleRegular13.copyWith(
            color: Color(0xffB3B3B3),
            fontSize: 12,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
