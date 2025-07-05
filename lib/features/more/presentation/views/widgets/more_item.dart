import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class MoreItem extends StatelessWidget {
  const MoreItem({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });
  final String image, title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ListTile(
            leading: SvgPicture.asset(image),
            title: Text(
              title,
              style: AppStyles.styleMedium19.copyWith(
                color: Color(0xff333333),
              ),
            ),
            trailing: Image.asset(Assets.imagesMoreArrorw),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Divider(
          color: Color(0xffE6E6E6),
          thickness: 1,
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
