import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/analytics/presentation/views/widgets/category_overstocking_dropdown_list.dart';

class CategoryOverstockingWidget extends StatefulWidget {
  const CategoryOverstockingWidget({
    super.key,
    required this.categoryOverstockingProducts,
    required this.categoryOverstockingProductsValues,
    required this.categoryOverstockingProductsValuesChanges,
  });
  final List<String> categoryOverstockingProducts;
  final List<int> categoryOverstockingProductsValues;
  final List<double> categoryOverstockingProductsValuesChanges;

  @override
  State<CategoryOverstockingWidget> createState() =>
      _CategoryOverstockingWidgetState();
}

class _CategoryOverstockingWidgetState
    extends State<CategoryOverstockingWidget> {
  int _selectedIndex = 0;

  void _onDropDownItemSelected(String? selectedItem) {
    if (selectedItem != null) {
      setState(() {
        _selectedIndex =
            widget.categoryOverstockingProducts.indexOf(selectedItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                Assets.imagesCategoryOverstockingSlider,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category Overstocking',
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
                    '${widget.categoryOverstockingProductsValues[_selectedIndex]}%',
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
                      SvgPicture.asset(
                          widget.categoryOverstockingProductsValuesChanges[
                                      _selectedIndex] >=
                                  0
                              ? Assets.imagesGreenRate
                              : Assets.imagesRedRate),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        '${widget.categoryOverstockingProductsValuesChanges[_selectedIndex]}%', // Display with 2 decimal places for better readability
                        style: AppStyles.styleRegular16.copyWith(
                          color:
                              widget.categoryOverstockingProductsValuesChanges[
                                          _selectedIndex] >=
                                      0
                                  ? const Color(0xff4FDB77)
                                  : const Color(0xffE14D4D),
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
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              CategoryOverstockingDropDownList(
                items: widget.categoryOverstockingProducts,
                onItemSelected: _onDropDownItemSelected,
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 200,
              ),
              SvgPicture.asset(Assets.imagesCategoryOverStatcking),
            ],
          ),
        ],
      ),
    );
  }
}
