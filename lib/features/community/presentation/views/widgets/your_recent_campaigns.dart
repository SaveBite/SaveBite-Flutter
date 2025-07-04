import 'package:flutter/material.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/features/community/presentation/views/widgets/dointation_card.dart';

class YourRecentCampaigns extends StatelessWidget {
  const YourRecentCampaigns({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 195,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          DonationCard(
            statusBackGroundColorColor: Color(0xffCCCCCC),
            date: 'May 27, 2025',
            organizationName: 'Misr El Kheir',
            organizationImage: Assets.imagesMisrElKhair,
            donatedItem: '27Kg Vegetables',
            cityName: 'Giza',
            status: 'On Progress',
            statusColor: const Color(0xff999999),
            statusImage: Assets.imagesOnProgress,
            onDetailsTap: () {},
          ),
          SizedBox(
            width: 8,
          ),
          DonationCard(
            statusBackGroundColorColor: Color(0xff5EDA42),
            date: 'May 24, 2025',
            organizationName: 'Ahl Misr',
            organizationImage: Assets.imagesAhlMisr,
            donatedItem: '10 Bread,8 Milk',
            cityName: 'Alexandria',
            status: 'Delivered',
            statusColor: const Color(0xffFFFFFF),
            statusImage: Assets.imagesDeliverd,
            onDetailsTap: () {},
          ),
          SizedBox(
            width: 8,
          ),
          DonationCard(
            statusBackGroundColorColor: Color(0xffCCCCCC),
            date: 'May 27, 2025',
            organizationName: 'Misr El Kheir',
            organizationImage: Assets.imagesMisrElKhair,
            donatedItem: '27Kg Vegetables',
            cityName: 'Giza',
            status: 'On Progress',
            statusColor: const Color(0xff999999),
            statusImage: Assets.imagesOnProgress,
            onDetailsTap: () {},
          ),
          SizedBox(
            width: 8,
          ),
          DonationCard(
            statusBackGroundColorColor: Color(0xff5EDA42),
            date: 'May 24, 2025',
            organizationName: 'Ahl Misr',
            organizationImage: Assets.imagesAhlMisr,
            donatedItem: '10 Bread,8 Milk',
            cityName: 'Alexandria',
            status: 'Delivered',
            statusColor: const Color(0xffFFFFFF),
            statusImage: Assets.imagesDeliverd,
            onDetailsTap: () {},
          ),
          SizedBox(
            width: 8,
          ),
        ]),
      ),
    );
  }
}
