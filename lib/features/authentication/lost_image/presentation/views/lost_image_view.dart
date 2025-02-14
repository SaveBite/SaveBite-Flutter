import 'package:flutter/material.dart';
import 'package:save_bite/constants.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/views/widgets/lost_image_view_body.dart';

class LostImageView extends StatelessWidget {
  const LostImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimryColor,
      body: LostImageViewBody(),
    );
  }
}
