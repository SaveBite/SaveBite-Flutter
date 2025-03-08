import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/manger/lost_image_cubit/lost_image_cubit.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/views/widgets/custom_drop_down_widget.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_text_form_field.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/views/widgets/lost_image_buttom_bloc_builder.dart';

class LostImageViewBody extends StatefulWidget {
  const LostImageViewBody({super.key});

  @override
  State<LostImageViewBody> createState() => _LostImageViewBodyState();
}

class _LostImageViewBodyState extends State<LostImageViewBody> {
  GlobalKey<FormState> myKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Form(
            key: myKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(Assets.imagesLeftIcon),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Lost your image!',
                  style: AppStyles.styleMedium23,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'A verification code will be sent to your mail, Please',
                  style: AppStyles.styleRegular16
                      .copyWith(color: Color(0xffB3B3B3), fontSize: 13),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'check it.',
                  style: AppStyles.styleRegular16
                      .copyWith(color: Color(0xffB3B3B3), fontSize: 13),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Enter your email',
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
                    BlocProvider.of<LostImageCubit>(context).email = value;
                    BlocProvider.of<LostImageCubit>(context)
                        .changeLostImageButtomColor();
                  },
                  hint: 'example@gmail.com',
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Please answer this question',
                      style: AppStyles.styleRegular16.copyWith(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                CustomDropDown(),
                SizedBox(
                  height: 50,
                ),
                LostImageButtomBlocBuilder(
                  myKey: myKey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
