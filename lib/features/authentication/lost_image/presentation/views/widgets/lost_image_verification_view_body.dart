import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_text_button.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/manger/lost_image_cubit/lost_image_cubit.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/views/widgets/custom_verification_field.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/views/widgets/lost_image_verification_buttom_bloc_builder.dart';

class LostImageVerificationViewBody extends StatefulWidget {
  const LostImageVerificationViewBody({super.key});

  @override
  State<LostImageVerificationViewBody> createState() =>
      _LostImageVerificationViewBodyState();
}

class _LostImageVerificationViewBodyState
    extends State<LostImageVerificationViewBody> {
  GlobalKey<FormState> myKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
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
                  'Verification!',
                  style: AppStyles.styleMedium23,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Enter the code sent to ${BlocProvider.of<LostImageCubit>(context).email}',
                  style: AppStyles.styleRegular16.copyWith(
                    color: Color(0xffB3B3B3),
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    CustomVerficationField(
                      onChanged: (value) {
                        BlocProvider.of<LostImageCubit>(context).val1 = value;
                        BlocProvider.of<LostImageCubit>(context)
                            .changeLostImageVerificationButtomColor();
                      },
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    CustomVerficationField(
                      onChanged: (value) {
                        BlocProvider.of<LostImageCubit>(context).val2 = value;
                        BlocProvider.of<LostImageCubit>(context)
                            .changeLostImageVerificationButtomColor();
                      },
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    CustomVerficationField(
                      onChanged: (value) {
                        BlocProvider.of<LostImageCubit>(context).val3 = value;
                        BlocProvider.of<LostImageCubit>(context)
                            .changeLostImageVerificationButtomColor();
                      },
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    CustomVerficationField(
                      onChanged: (value) {
                        BlocProvider.of<LostImageCubit>(context).val4 = value;
                        BlocProvider.of<LostImageCubit>(context)
                            .changeLostImageVerificationButtomColor();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                LostImageVerificationButtomBlocBuilder(
                  myKey: myKey,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn\'t get the code?',
                      style: AppStyles.styleRegular13.copyWith(
                        color: Color(0xff000000),
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    CustomTextButton(
                      onTap: () async {
                        await BlocProvider.of<LostImageCubit>(context)
                            .lostmImage();
                      },
                      title: 'Click to resend',
                      textStyle: AppStyles.styleRegular13.copyWith(
                        color: Color(0xffFF0000),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
