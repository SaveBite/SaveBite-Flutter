import 'package:flutter/material.dart';
import 'package:save_bite/features/community/presentation/views/widgets/charity_section.dart';
import 'package:save_bite/features/community/presentation/views/widgets/community_header.dart';
import 'package:save_bite/features/community/presentation/views/widgets/explore_secion.dart';
import 'package:save_bite/features/community/presentation/views/widgets/your_recent_campaigns.dart';

class CommunityViewBody extends StatelessWidget {
  const CommunityViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CoomunityHeader(),
            SizedBox(
              height: 24,
            ),
            YourRecentCampaigns(),
            SizedBox(
              height: 24,
            ),
            ExploreSection(),
            SizedBox(
              height: 24,
            ),
            CharitySection(),
          ],
        ),
      ),
    );
  }
}
