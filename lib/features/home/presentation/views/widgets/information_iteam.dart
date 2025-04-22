import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/home/data/models/information_iteam_model.dart';

class InformationIteam extends StatelessWidget {
  const InformationIteam(
      {super.key, required this.informationIteamModel, required this.value});
  final InformationIteamModel informationIteamModel;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.only(
        left: 8,
        top: 16,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Color(0xffFFFFFF),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                informationIteamModel.title,
                style: AppStyles.styleRegular16.copyWith(
                  fontSize: 13,
                  color: Color(0xff1A1A1A),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.styleBold16.copyWith(
                    color: Color(0xff1A1A1A),
                    fontSize: 13,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Spacer(),
              SvgPicture.asset(
                informationIteamModel.image,
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
