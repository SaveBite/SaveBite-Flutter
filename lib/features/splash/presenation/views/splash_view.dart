import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:save_bite/core/utils/app_router.dart';
import 'package:save_bite/features/authentication/login/presentation/manger/login_cubit/login_cubit.dart';
import 'package:save_bite/features/splash/presenation/views/widgets/splash_view_body.dart';

class SplahView extends StatefulWidget {
  const SplahView({super.key});

  @override
  State<SplahView> createState() => _SplahViewState();
}

class _SplahViewState extends State<SplahView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (BlocProvider.of<LoginCubit>(context).rememberMe == true) {
          GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
        } else {
          GoRouter.of(context).pushReplacement(AppRouter.kLoginEmailImageView);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5EDA42),
      body: SplashViewBody(),
    );
  }
}
