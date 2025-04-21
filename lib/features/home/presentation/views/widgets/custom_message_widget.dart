import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/home/presentation/manger/stock_data_cubit/stock_data_cubit.dart';

class CustomAllertWidget extends StatelessWidget {
  const CustomAllertWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 24,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffEDFBEA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset(Assets.imagesI),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Easily import your product data to',
                style: AppStyles.styleRegular16.copyWith(
                  color: Color(0xff1A1A1A),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'streamline your workflow. Make ',
                style: AppStyles.styleRegular16.copyWith(
                  color: Color(0xff1A1A1A),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'sure the file includes accurate ',
                style: AppStyles.styleRegular16.copyWith(
                  color: Color(0xff1A1A1A),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'details for each product.',
                style: AppStyles.styleRegular16.copyWith(
                  color: Color(0xff1A1A1A),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              BlocProvider.of<StockDataCubit>(context).removeAlertMessage();
            },
            child: SvgPicture.asset(Assets.imagesX),
          ),
        ],
      ),
    );
  }
}
