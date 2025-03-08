import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/authentication/login/presentation/manger/login_cubit/login_cubit.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_check_box.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_text_form_field.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/login_email_password_buttom_bloc_builder.dart';

class LoginEmailPasswordForm extends StatefulWidget {
  const LoginEmailPasswordForm({super.key});

  @override
  State<LoginEmailPasswordForm> createState() => _LoginEmailPasswordFormState();
}

class _LoginEmailPasswordFormState extends State<LoginEmailPasswordForm> {
  GlobalKey<FormState> myKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: myKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: AppStyles.styleRegular16,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          CustomTextFormField(
            validator: (value) {
              if (value == "") {
                return 'the field is requride';
              } else {
                return null;
              }
            },
            onChanged: (value) {
              BlocProvider.of<LoginCubit>(context).email = value;
              BlocProvider.of<LoginCubit>(context).chaneButtomColor();
            },
            hint: 'example@gmail.com',
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Password',
                style: AppStyles.styleRegular16,
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          CustomTextFormField(
            validator: (value) {
              if (value == "") {
                return 'the field is requride';
              } else {
                return null;
              }
            },
            obscureToggleWidget: SvgPicture.asset(Assets.imagesEyeOff),
            visibleToggleWidget: SvgPicture.asset(Assets.imagesEyeOn),
            onChanged: (value) {
              BlocProvider.of<LoginCubit>(context).password = value;
              BlocProvider.of<LoginCubit>(context).chaneButtomColor();
            },
            obscureText: true, // Optional: Sets the initial visibility
            hint: 'Password',
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              CustomCheckBox(),
              SizedBox(
                width: 10,
              ),
              Text(
                'Remember me',
                style:
                    AppStyles.styleRegular13.copyWith(color: Color(0xff000000)),
              ),
            ],
          ),
          SizedBox(
            height: 48,
          ),
          LoginEmailPasswordButtomBlocBuilder(
            myKey: myKey,
          ),
        ],
      ),
    );
  }
}
