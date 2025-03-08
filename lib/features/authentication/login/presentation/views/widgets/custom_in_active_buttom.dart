import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_button.dart';

class CustomInActiveButtom extends StatelessWidget {
  const CustomInActiveButtom(
      {super.key, this.onTap, required this.content, this.icon = true});
  final void Function()? onTap;
  final String content;
  final bool icon;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: onTap,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            content,
            style: AppStyles.styleMedium16.copyWith(
              color: Color(0xffFFFFFF),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          icon
              ? SvgPicture.asset(
                  Assets.imagesForwardRightIcon,
                )
              : SizedBox(),
        ],
      ),
      color: Color(0xffE6E6E6),
      borderColor: Color(0xffE6E6E6),
    );
  }
}
