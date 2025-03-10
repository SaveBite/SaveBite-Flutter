import 'package:flutter/material.dart';
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
            height: 16,
          ),
        ],
      ),
    );
  }
}
