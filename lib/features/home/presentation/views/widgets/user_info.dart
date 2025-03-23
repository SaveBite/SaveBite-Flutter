import 'package:flutter/material.dart';
import 'package:save_bite/features/home/presentation/views/widgets/search_any_thing_field.dart';
import 'package:save_bite/features/home/presentation/views/widgets/user_info_header.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        bottom: 16,
        right: 16,
        top: 24,
        left: 16,
      ),
      decoration: BoxDecoration(
        color: Color(0xff5EDA42),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          UserInfoHeader(),
          SizedBox(
            height: 16,
          ),
          SearchAnyThingField(),
        ],
      ),
    );
  }
}
