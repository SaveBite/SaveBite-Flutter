import 'package:go_router/go_router.dart';
import 'package:save_bite/features/authentication/login/presentation/views/loading_page_email_image_view.dart';
import 'package:save_bite/features/authentication/login/presentation/views/loading_page_email_password_view.dart';
import 'package:save_bite/features/authentication/login/presentation/views/login_email_image_view.dart';
import 'package:save_bite/features/authentication/login/presentation/views/login_email_password_view.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/views/check_your_email_view.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/views/lost_image_view.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/views/lost_mage_verification_view.dart';
import 'package:save_bite/features/authentication/sign_up/presentation/pages/sign_up_page.dart';
import 'package:save_bite/features/home/home_view.dart';
import 'package:save_bite/features/splash/presenation/views/splash_view.dart';

abstract class AppRouter {
  static const kLoginEmailImageView = '/loginEmailImageView';
  static const kLoginEmailPasswordView = '/loginEmailPassswordView';
  static const kLostImageView = '/lostImageView';
  static const kHomeView = '/homeView';
  static const kLoadingPageEmailImageView = '/loadingPageEmailImageView';
  static const kLoadingPageEmailPasswordView = '/loadingPageEmailPasswordView';
  static const kSignupView = '/sinupView';
  static const kLostImageVerificationView = '/lostImageVerificationView';
  static const kCheckYourEmailView = '/kCheckYourEmailView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => SplahView(),
      ),
      GoRoute(
        path: kLoginEmailImageView,
        builder: (context, state) => LoginEmailImageView(),
      ),
      GoRoute(
        path: kLoginEmailPasswordView,
        builder: (context, state) => LoginEmailPasswordView(),
      ),
      GoRoute(
        path: kLostImageView,
        builder: (context, state) => LostImageView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => HomeView(),
      ),
      GoRoute(
        path: kLoadingPageEmailImageView,
        builder: (context, state) => LoadingPageEmailImageView(),
      ),
      GoRoute(
        path: kLoadingPageEmailPasswordView,
        builder: (context, state) => LoadingPageEmailPasswordView(),
      ),
      GoRoute(
        path: kSignupView,
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: kLostImageVerificationView,
        builder: (context, state) => LostImageVerificationView(),
      ),
      GoRoute(
        path: kCheckYourEmailView,
        builder: (context, state) => CheckYourEmailView(),
      ),
    ],
  );
}
