import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class StockTurnOverWidget extends StatelessWidget {
  const StockTurnOverWidget({
    super.key,
    required this.stockTurnOverRate,
    required this.stockTurnOverRateChange,
  });
  final int stockTurnOverRate;
  final double stockTurnOverRateChange;

  @override
  Widget build(BuildContext context) {
    Color changeTextColor = stockTurnOverRateChange >= 0
        ? const Color(0xff4FDB77)
        : const Color(0xffE14D4D);
    String changeRateAsset = stockTurnOverRateChange >= 0
        ? Assets.imagesGreenRate
        : Assets.imagesRedRate;

    return Container(
      height: 162,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 8,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                Assets.imagesStockTurnOverRateSlider,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stock Turnover Rate ',
                    style: AppStyles.styleRegular16.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff1A1A1A),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    '$stockTurnOverRate%',
                    style: AppStyles.styleBold16.copyWith(
                      color: const Color(0xff1A1A1A),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(changeRateAsset),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        '${stockTurnOverRateChange.toStringAsFixed(2)}%', // Display with 2 decimal places for better readability
                        style: AppStyles.styleRegular16.copyWith(
                          color: changeTextColor,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Since last month',
                        style: AppStyles.styleRegular11.copyWith(
                          fontSize: 11,
                          color: const Color(0xffB3B3B3),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 110,
                      ),
                      SvgPicture.asset(Assets.imagesStockTurnOverRate),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
