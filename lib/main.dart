import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/core/utils/app_router.dart';
import 'package:save_bite/core/utils/functions/intial_hive.dart';
import 'package:save_bite/core/utils/service_locator.dart';
import 'package:save_bite/features/authentication/login/domain/use_case/login_email_image_use_case.dart';
import 'package:save_bite/features/authentication/login/domain/use_case/login_email_password__use_case.dart';
import 'package:save_bite/features/authentication/login/presentation/manger/login_cubit/login_cubit.dart';
import 'package:save_bite/features/authentication/lost_image/domain/use_case/lost_image_use_case.dart';
import 'package:save_bite/features/authentication/lost_image/domain/use_case/lost_image_verfication_use_case.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/manger/lost_image_cubit/lost_image_cubit.dart';

void main() async {
  await intialHive();
  setupServiceLocator();
  runApp(const SaveBite());
}

class SaveBite extends StatelessWidget {
  const SaveBite({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(
            loginEmailImageUseCase: getit.get<LoginEmailImageUseCase>(),
            loginEmailPasswordUseCase: getit.get<LoginEmailPasswordUseCase>(),
          )..getUserAndRememberMe(),
        ),
        BlocProvider(
          create: (context) => LostImageCubit(
            lostImgeUseCase: getit.get<LostImageUseCase>(),
            lostImageVerficationUseCase:
                getit.get<LostImageVerficationUseCase>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
