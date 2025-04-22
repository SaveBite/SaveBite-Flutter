import 'package:flutter/material.dart';
import 'package:save_bite/features/home/widgets/add_iteam_widget.dart';
import 'package:save_bite/features/home/widgets/custom_filter_widget.dart';
import 'package:save_bite/features/home/widgets/custom_message_widget.dart';
import 'package:save_bite/features/home/widgets/search_product_field.dart';
import 'package:save_bite/features/home/widgets/user_info.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserInfo(),
          SizedBox(
            height: 24,
          ),
          CustomAllertWidget(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Row(
              children: [
                SearchProductField(),
                Spacer(),
                CustomFilterWidget(),
                SizedBox(
                  width: 8,
                ),
                AddIteamWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
