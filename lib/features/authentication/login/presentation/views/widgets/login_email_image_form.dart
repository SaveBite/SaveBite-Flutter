import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:save_bite/core/utils/app_router.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/authentication/login/presentation/manger/login_cubit/login_cubit.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_check_box.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_text_form_field.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_under_line_text_button.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/login_email_image_buttom_bloc_builder.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/upload_image_text_field.dart';

class LoginEmailImageForm extends StatefulWidget {
  const LoginEmailImageForm({super.key});

  @override
  State<LoginEmailImageForm> createState() => _LoginEmailImageFormState();
}

class _LoginEmailImageFormState extends State<LoginEmailImageForm> {
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
                'Upload your image',
                style: AppStyles.styleRegular16,
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          UplaodImageTextField(),
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
              Spacer(),
              CustomUnderLineTextButton(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kLostImageView);
                },
                title: 'Lost your image?',
              ),
            ],
          ),
          SizedBox(
            height: 48,
          ),
          LoginEmailImageButtomBlocBuilder(
            myKey: myKey,
          ),
        ],
      ),
    );
  }
}
