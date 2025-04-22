import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/authentication/login/presentation/views/login_email_image_view.dart';

import '../../../../../core/utils/app_assets.dart';

class ApprovedVerification extends StatelessWidget {
  const ApprovedVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.imagesVerifiedIcon),
              SizedBox(
                height: 40,
              ),
              Text(
                // "Check your email",
                "Successfully",
                style: AppStyles.styleMedium28,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'your Account has been Created.',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff999999),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Noto Scans'),
              ),

              SizedBox(
                height: 20,
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginEmailImageView(),
                    ),
                  );
                },
                label: Text(
                  "Back to login",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Noto Scans',
                    color: Color(0xff5EDA42),
                    decorationColor: Color(0xff5EDA42),
                  ),
                ),
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xff5EDA42),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
