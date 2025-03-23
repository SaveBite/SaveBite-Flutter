import 'package:flutter/material.dart';
import 'package:save_bite/constants.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/loading_page_email_image_view_body.dart';

class LoadingPageEmailImageView extends StatelessWidget {
  const LoadingPageEmailImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimryColor,
      body: LoadingPageEmailImageViewBody(),
    );
  }
}
