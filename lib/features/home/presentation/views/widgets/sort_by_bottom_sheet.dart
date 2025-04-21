import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/home/presentation/manger/products_cubit/products_cubit.dart';

class SortByBottomSheet extends StatefulWidget {
  const SortByBottomSheet({super.key, required this.blocContext});
  final BuildContext blocContext;

  @override
  State<SortByBottomSheet> createState() => _SortByBottomSheetState();
}

class _SortByBottomSheetState extends State<SortByBottomSheet> {
  String? selectedSortOption;

  @override
  void initState() {
    super.initState();
    selectedSortOption = "PositiveStock";
  }

  void _handleSortOptionSelected(String value) {
    setState(() {
      selectedSortOption = value;
      BlocProvider.of<ProductsCubit>(widget.blocContext).sortBy = value;
    });
  }

  Widget _buildSortOptionRow(String title, String value) {
    return InkWell(
      onTap: () {
        _handleSortOptionSelected(value);
      },
      child: Row(
        children: [
          Text(
            title,
            style: AppStyles.styleRegular16.copyWith(
              color: Color(0xff1A1A1A),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          Spacer(),
          Radio<String>(
            value: value,
            groupValue: selectedSortOption,
            onChanged: (newValue) {},
            activeColor: Color(0xFF5EDA42),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          )),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'SORT BY',
              style: AppStyles.styleMedium16.copyWith(
                color: Color(0xff999999),
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _buildSortOptionRow("Postitive Stock", "PositiveStock"),
            _buildSortOptionRow("Negative Stock", "NegativeStock"),
            _buildSortOptionRow("Below Bar", "BelowPar"),
            _buildSortOptionRow("Below Minimum", "BelowMinimum"),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<ProductsCubit>(widget.blocContext)
                    .sortProductsBy();
                Navigator.of(context).pop();
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.0551643192488263,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xff5EDA42),
                ),
                child: Center(
                  child: Text(
                    'Apply',
                    style: AppStyles.styleBold19
                        .copyWith(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
