import 'package:flutter/material.dart';
import 'package:save_bite/constants.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/login_email_password_view_body.dart';

class LoginEmailPasswordView extends StatelessWidget {
  const LoginEmailPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimryColor,
      body: LoginEmailPsswordViewBody(),
    );
  }
}