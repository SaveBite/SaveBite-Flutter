import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.leadingIcon,
    this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: AppStyles.styleRegular16,
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Noto Scans',
              color: Color(0xff333333),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Noto Scans',
                color: Color(0xffCCCCCC),
              ),
              errorStyle: const TextStyle(color: Color(0xffFF0000)), // Red color for errors
              prefixIcon: leadingIcon,
              suffixIcon: trailingIcon,
              suffixIconColor: const Color(0xff666666),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff5EDA42), width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffCCCCCC)),
                borderRadius: BorderRadius.circular(4),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffFF0000)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffFF0000)), // Custom color for errors
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 16),
            ),
            validator: validator, // Use the provided validator
            obscureText: obscureText,
            keyboardType: keyboardType,
            autovalidateMode: AutovalidateMode.onUserInteraction, // Validate as the user types
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}