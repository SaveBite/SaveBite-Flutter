import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/authentication/login/data/model/save_user_data.dart';

class UserInfoHeader extends StatelessWidget {
  const UserInfoHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            'https://i.pravatar.cc/150?img=3',
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          'Hello,',
          style: AppStyles.styleMedium19
              .copyWith(color: Color(0xffFFFFFF), fontWeight: FontWeight.w400),
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          "${SaveUserData.user?.name ?? ''}!",
          style: AppStyles.styleMedium19.copyWith(
            color: Color(0xffFFFFFF),
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            backgroundColor: Colors.white70,
            child: SvgPicture.asset(Assets.imagesNotification),
          ),
        )
      ],
    );
  }
}
