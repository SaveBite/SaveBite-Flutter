import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_bite/core/utils/functions/intial_hive.dart';
import 'package:save_bite/features/authentication/login/domain/use_case/login_email_image_use_case.dart';
import 'package:save_bite/features/authentication/login/domain/use_case/login_email_password__use_case.dart';
import 'package:save_bite/features/authentication/login/presentation/manger/login_cubit/login_cubit.dart';
import 'package:save_bite/features/authentication/lost_image/domain/use_case/lost_image_use_case.dart';
import 'package:save_bite/features/authentication/lost_image/domain/use_case/lost_image_verfication_use_case.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/manger/lost_image_cubit/lost_image_cubit.dart';
import 'package:save_bite/features/authentication/sign_up/presentation/bloc/authentication_bloc.dart';
import 'package:save_bite/features/authentication/verification/presentation/bloc/otp_bloc.dart';
import 'package:save_bite/features/splash/presenation/views/splash_view.dart';
import 'core/utils/app_styles.dart';
import 'features/ChatBot/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'features/ChatBot/presentation/bloc/recipe_bloc/recipe_bloc.dart';
import 'features/Tracking/Presentation/bloc/tracking_product_bloc.dart';
import 'features/stock/domain/entites/product_filter_entity.dart';
import 'features/stock/presentation/bloc/stock_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await intialHive();

  di.sl.reset();
  await di.init();

  runApp(SaveBite());
}

class SaveBite extends StatefulWidget {
  const SaveBite({super.key});

  @override
  State<SaveBite> createState() => _SaveBiteState();
}

class _SaveBiteState extends State<SaveBite> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.sl<AuthenticationBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<OTPBloc>(),
          ),
          BlocProvider(
            create: (context) => LoginCubit(
              loginEmailImageUseCase: di.sl<LoginEmailImageUseCase>(),
              loginEmailPasswordUseCase: di.sl<LoginEmailPasswordUseCase>(),
            ),
          ),
          BlocProvider(
            create: (context) => LostImageCubit(
              lostImgeUseCase: di.sl<LostImageUseCase>(),
              lostImageVerficationUseCase: di.sl<LostImageVerficationUseCase>(),
            ),
          ),
          BlocProvider(
            create: (_) => di.sl<StockBloc>()
              ..add(GetStockProductsEvent(filter: ProductFilterEntity())),
          ),
          BlocProvider(
            create: (_) => di.sl<RecipeBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<ChatBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<TrackingAddEditBloc>(),
          ),
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
          // home: TrackingAddEditPage(),
          // home: AddEditProductPage(isEdit: false), // Default to add screen
          home: SplahView(),

        ),
      ),
    );
  }
}