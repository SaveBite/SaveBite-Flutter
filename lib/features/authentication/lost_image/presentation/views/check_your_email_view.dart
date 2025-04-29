import 'package:flutter/material.dart';
import 'package:save_bite/constants.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/views/widgets/check_your_email_view_body.dart';

class CheckYourEmailView extends StatelessWidget {
  const CheckYourEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimryColor,
      body: CheckYourEmailViewBody(),
    );
  }
}
