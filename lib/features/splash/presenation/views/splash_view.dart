import 'package:flutter/material.dart';
import 'package:save_bite/features/splash/presenation/views/widgets/splash_view_body.dart';

class SplahView extends StatelessWidget {
  const SplahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5EDA42),
      body: const SplashViewBody(
      ),
    );
  }
}
