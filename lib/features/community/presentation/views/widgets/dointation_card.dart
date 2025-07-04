import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class DonationCard extends StatelessWidget {
  final String date;
  final String organizationName;
  final String organizationImage;
  final String donatedItem;
  final String cityName;
  final String status;
  final Color statusColor;
  final Color statusBackGroundColorColor;

  final VoidCallback onDetailsTap;
  final String statusImage;

  const DonationCard({
    super.key,
    required this.date,
    required this.organizationName,
    required this.organizationImage,
    required this.status,
    required this.statusColor,
    required this.onDetailsTap,
    required this.donatedItem,
    required this.cityName,
    required this.statusImage,
    required this.statusBackGroundColorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 525,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Container(
            height: 37,
            width: 200,
            decoration: BoxDecoration(
              color: Color(0xffEDFBEA),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: AppStyles.styleMedium10.copyWith(
                      color: Color(0xff999999),
                      fontSize: 11,
                    ),
                  ),
                  GestureDetector(
                    onTap: onDetailsTap,
                    child: Text(
                      "See Details",
                      style: AppStyles.styleBold11.copyWith(
                        color: Color(0xff5EDA42),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Org Logo & Name
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Row(
              children: [
                Image.asset(organizationImage),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    organizationName,
                    style: AppStyles.styleBold16.copyWith(
                      color: Color(0xff1A1A1A),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Donated
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.imagesDonated,
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Donated : $donatedItem',
                    style: AppStyles.styleMedium10.copyWith(
                      color: Color(0xff1A1A1A),
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // Location
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Row(
              children: [
                SvgPicture.asset(Assets.imagesLocation),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Location : $cityName',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF4D4D4D),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Status
          Container(
            height: 28,
            width: 97,
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: statusBackGroundColorColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(statusImage),
                const SizedBox(width: 6),
                Text(
                  status,
                  style: AppStyles.styleBold11.copyWith(
                    color: statusColor,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
