import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_router.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_button.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_text_button.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/login_email_image_form.dart';

class LoginEmailImageViewBody extends StatelessWidget {
  const LoginEmailImageViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 32,
              ),
              SvgPicture.asset(Assets.imagesAuthLogo),
              SizedBox(
                height: 40,
              ),
              Text(
                'Welcome back!',
                style: AppStyles.styleMedium23,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 32,
              ),
              LoginEmailImageForm(),
              SizedBox(
                height: 12,
              ),
              CustomButton(
                onTap: () {
                  GoRouter.of(context)
                      .pushReplacement(AppRouter.kLoginEmailPasswordView);
                },
                content: Text(
                  'Login with email and password',
                  style: AppStyles.styleMedium16
                      .copyWith(color: Color(0xff5EDA42), fontSize: 14),
                ),
                color: Color(0xffffffff),
                borderColor: Color(0xff5EDA42),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do not have an account?',
                    style: AppStyles.styleRegular13.copyWith(
                      color: Color(0xff000000),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  CustomTextButton(
                    onTap: () {
                       GoRouter.of(context)
                      .pushReplacement(AppRouter.kSignupView);
                    },
                    title: 'Sign up',
                  ),
                ],
              ),
              SizedBox(
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
