import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/authentication/login/presentation/manger/login_cubit/login_cubit.dart';
import 'package:save_bite/features/authentication/login/presentation/views/login_email_password_view.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_message_widget.dart';
import 'package:save_bite/features/home/presentation/views/home_view.dart';

class LoadingPageEmailPasswordViewBody extends StatefulWidget {
  const LoadingPageEmailPasswordViewBody({super.key});

  @override
  LoadingPageEmailPasswordViewBodyState createState() =>
      LoadingPageEmailPasswordViewBodyState();
}

class LoadingPageEmailPasswordViewBodyState
    extends State<LoadingPageEmailPasswordViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: 300), // Increased duration for slower animation
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showOverlayWidget(context, state.errorMessage);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginEmailPasswordView(),
            ),
          );
        } else if (state is LoginSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ),
          );
        }
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnimatedDot(0, _animationController),
                const SizedBox(width: 16),
                _buildAnimatedDot(1, _animationController),
                const SizedBox(width: 16),
                _buildAnimatedDot(2, _animationController),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "We are almost there...",
              style: AppStyles.styleRegular19
                  .copyWith(color: const Color(0xff5EDA42)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedDot(int index, AnimationController controller) {
    final double offset = 5;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double yOffset = 0;
        int delay = index * 150; // Increased delay for smoother animation

        if (controller.value * 1000 > delay) {
          double progress =
              (controller.value * 1000 - delay) / 300; // Adjusted divisor
          if (progress <= 1) {
            yOffset = -offset * progress;
          } else if (progress <= 2) {
            yOffset = offset * (progress - 1);
          } else {
            yOffset = -offset * (progress - 2);
          }
        }

        return Transform.translate(
          offset: Offset(0, yOffset),
          child: SvgPicture.asset(
            Assets.imagesDotIcon,
            width: 20,
            height: 20,
          ),
        );
      },
    );
  }
}
