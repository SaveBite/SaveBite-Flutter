import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/features/authentication/login/data/model/save_user_data.dart';
import 'package:save_bite/features/authentication/login/presentation/manger/login_cubit/login_cubit.dart';
import 'package:save_bite/features/authentication/login/presentation/views/login_email_image_view.dart';
import 'package:save_bite/features/home/presentation/views/home_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginCubit>(context).getUserAndRememberMe();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (SaveUserData.rememberMe == true) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const HomeView();
              },
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginEmailImageView(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(Assets.imagesSplashLogo),
    );
  }
}
