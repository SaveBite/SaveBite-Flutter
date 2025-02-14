import 'package:flutter/material.dart';
import 'package:save_bite/constants.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/login_email_image_view_body.dart';

class LoginEmailImageView extends StatelessWidget {
  const LoginEmailImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimryColor,
      body: LoginEmailImageViewBody(),
    );
  }
}
