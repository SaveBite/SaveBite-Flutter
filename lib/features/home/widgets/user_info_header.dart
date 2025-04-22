import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/authentication/login/presentation/manger/login_cubit/login_cubit.dart';

class UserInfoHeader extends StatelessWidget {
  const UserInfoHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Color(0xffFFFFFF),
          child: SvgPicture.asset(Assets.imagesPeople),
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
          "${BlocProvider.of<LoginCubit>(context).userModel!.name}!",
          style: AppStyles.styleMedium19.copyWith(
            color: Color(0xffFFFFFF),
          ),
        ),
        Spacer(),
        CircleAvatar(
          backgroundColor: Colors.white70,
          child: SvgPicture.asset(Assets.imagesNotification),
        )
      ],
    );
  }
}
