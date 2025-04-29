import 'package:flutter/material.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class CustomAddIteamField extends StatelessWidget {
  const CustomAddIteamField({super.key, this.onChanged, required this.title});
  final void Function(String)? onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
        ),
        Text(
          title,
          style: AppStyles.styleRegular16.copyWith(
            color: Color(0xff666666),
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'this field is requied';
            } else {
              return null;
            }
          },
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: Color(0xffCCCCCC),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xffCCCCCC),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xffCCCCCC),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
