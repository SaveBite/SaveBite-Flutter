import 'package:flutter/material.dart';
import 'package:save_bite/constants.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/loading_page_email_password__view_body.dart';

class LoadingPageEmailPasswordView extends StatelessWidget {
  const LoadingPageEmailPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimryColor,
      body: LoadingPageEmailPasswordViewBody(),
    );
  }
}
