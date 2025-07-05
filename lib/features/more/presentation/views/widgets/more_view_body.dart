import 'package:flutter/material.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/features/analytics/presentation/views/anyltics_view.dart';
import 'package:save_bite/features/authentication/login/data/model/save_user_data.dart';
import 'package:save_bite/features/authentication/login/presentation/views/login_email_image_view.dart';
import 'package:save_bite/features/community/presentation/views/community_view.dart';
import 'package:save_bite/features/more/presentation/views/widgets/change_photo_widget.dart';
import 'package:save_bite/features/more/presentation/views/widgets/more_item.dart';

class MoreViewBody extends StatelessWidget {
  const MoreViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ChangePhotoWidget(),
            SizedBox(
              height: 24,
            ),
            MoreItem(
              image: Assets.imagesAccount,
              title: 'Account',
            ),
            MoreItem(
              image: Assets.imagesAnalytics,
              title: 'Analytics & Reports',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AnylticsView();
                    },
                  ),
                );
              },
            ),
            MoreItem(
              image: Assets.imagesMoreCommunity,
              title: 'Community',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return CommunityView();
                    },
                  ),
                );
              },
            ),
            MoreItem(
              image: Assets.imagesSettings,
              title: 'Settings',
            ),
            MoreItem(
              image: Assets.imagesSupport,
              title: 'Support',
            ),
            MoreItem(
              image: Assets.imagesPrivicyPolicy,
              title: 'Privacy Policy',
            ),
            MoreItem(
              image: Assets.imagesAccount,
              title: 'Log out',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginEmailImageView();
                    },
                  ),
                );
                SaveUserData.rememberMe = null;
                SaveUserData.user = null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
