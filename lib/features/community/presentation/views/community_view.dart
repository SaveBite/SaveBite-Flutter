import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/community/presentation/views/widgets/community_view_body.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Transform.scale(
            scale: .4,
            child: SvgPicture.asset(Assets.imagesReturnBack),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Community',
          style: AppStyles.styleMedium19.copyWith(
            color: Color(0xff000000),
          ),
        ),
      ),
      body: CommunityViewBody(),
    );
  }
}
