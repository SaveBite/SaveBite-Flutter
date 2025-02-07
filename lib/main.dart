import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_bite/features/authentication/sign_up/presentation/bloc/authentication_bloc.dart';
import 'package:save_bite/features/authentication/sign_up/presentation/pages/sign_up_page.dart';
import 'package:save_bite/features/authentication/verification/presentation/bloc/otp_bloc.dart';
import 'core/utils/app_styles.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.sl.reset();
  await di.init();
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      builder: (context, child) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => di.sl<AuthenticationBloc>()),
            BlocProvider(create: (_)=> di.sl<OTPBloc>())
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                textTheme: TextTheme(
                  bodyLarge: AppStyles.styleRegular16,
                  bodyMedium: AppStyles.styleRegular13,
                  displayLarge: AppStyles.styleBold48,
                  displayMedium: AppStyles.styleMedium40,
                  displaySmall: AppStyles.styleRegular40,
                  titleMedium: AppStyles.styleMedium16,
                  titleSmall: AppStyles.styleRegular14,
                  bodySmall: AppStyles.styleRegular12,
                ),
                 scaffoldBackgroundColor: Color(0xffFFFFFF),
              ),

              home:SignUpPage())),
    );
  }
}
