import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:save_bite/core/utils/app_router.dart';
import 'package:save_bite/features/authentication/login/presentation/manger/login_cubit/login_cubit.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_active_buttom.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_in_active_buttom.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_message_widget.dart';

class LoginEmailPasswordButtomBlocBuilder extends StatelessWidget {
  const LoginEmailPasswordButtomBlocBuilder({
    super.key,
    required this.myKey,
  });

  final GlobalKey<FormState> myKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
        } else if (state is LoginFailure) {
          showOverlayWidget(context, state.errorMessage);
        } else if (state is LoginLoading) {
          GoRouter.of(context)
              .pushReplacement(AppRouter.kLoadingPageEmailPasswordView);
        }
      },
      builder: (context, state) {
        if (state is ButtomActive) {
          return CustomActiveButtom(
            content: 'Login',
            onTap: () async {
              if (myKey.currentState!.validate()) {
                await BlocProvider.of<LoginCubit>(context)
                    .loginEmailPassword();
              }
            },
          );
        } else {
          return CustomInActiveButtom(
            content: 'Login',
            onTap: () async {
              if (myKey.currentState!.validate()) {
                await BlocProvider.of<LoginCubit>(context)
                    .loginEmailPassword();
              }
            },
          );
        }
      },
    );
  }
}
