import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class CharityInformatonCard extends StatelessWidget {
  final String organizatonName;
  final String cityName;
  final String oragnizationLocation;
  final String oraganizationDescription;
  const CharityInformatonCard({
    super.key,
    required this.organizatonName,
    required this.cityName,
    required this.oragnizationLocation,
    required this.oraganizationDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Color(0xffFFFFFF),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Image.asset(
              fit: BoxFit.fill,
              Assets.imagesCharityDonation,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.imagesRedLocation,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      cityName,
                      style: AppStyles.styleRegular11.copyWith(
                        color: Color(0xffF7493E),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      oragnizationLocation,
                      style: AppStyles.styleRegular11.copyWith(
                        color: Color(0xffF7493E),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  organizatonName,
                  style: AppStyles.styleBold16.copyWith(
                    color: Color(0xff1A1A1A),
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 145,
                  child: Text(
                    'A national charity targeting hunger, education, and healthcare. Our food security branch distributes staple ingredients and clean water supplies to rural families in Upper Egypt.',
                    style: AppStyles.styleRegular11.copyWith(
                      fontSize: 10,
                      color: Color(0xff999999),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    height: 28,
                    decoration: BoxDecoration(
                      color: Color(0xff5EDA42),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'Donate now',
                        style: AppStyles.styleBold11.copyWith(
                          color: Color(0xffFFFFFF),
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                    height: 28,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffEDFBEA),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'View Profile',
                        style: AppStyles.styleBold11.copyWith(
                          color: Color(0xff5EDA42),
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
