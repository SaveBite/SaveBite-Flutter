import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_text_button.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/manger/lost_image_cubit/lost_image_cubit.dart';

class CheckYourEmailViewBody extends StatelessWidget {
  const CheckYourEmailViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pop();
                    },
                    child: SvgPicture.asset(Assets.imagesLeftIcon),
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              SvgPicture.asset(Assets.imagesVerifiedIcon),
              SizedBox(
                height: 40,
              ),
              Text(
                'Check your email',
                style: AppStyles.styleMedium28,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'We have sent an email to',
                    style: AppStyles.styleRegular16.copyWith(
                      fontSize: 13
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    BlocProvider.of<LostImageCubit>(context).email!,
                    style: AppStyles.styleRegular16.copyWith(
                      color: Color(0xff222222),
                      fontSize: 13
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                'with your image, Please Check it.',
                style: AppStyles.styleRegular16.copyWith(
                  fontSize: 13
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 0.9,
                    child: SvgPicture.asset(Assets.imagesForwardLeftIcon),
                    ),
                  SizedBox(
                    width: 4,
                  ),
                  CustomTextButton(
                    onTap: () {
                      GoRouter.of(context).pop();
                    },
                    title: 'Back to login',
                    textStyle: AppStyles.styleRegular19.copyWith(
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
