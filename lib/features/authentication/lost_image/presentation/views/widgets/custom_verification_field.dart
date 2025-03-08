import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class CustomVerficationField extends StatelessWidget {
  const CustomVerficationField({
    super.key,
    this.onChanged,
  });
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * .21,
      width: MediaQuery.of(context).size.width * .21,
      child: TextFormField(
        style: AppStyles.styleRegular28,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return ''; // Return empty string for no error message
          } else if (value.length > 1) {
            return 'Only one digit allowed'; // Error message for more than one digit
          }
          return null; // No error
        },
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1), // Limit to 1 character
          FilteringTextInputFormatter.digitsOnly, // Allow only digits
        ],
        textAlign: TextAlign.center,
        // Center the text
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(
              color: Color(0xff5EDA42),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(
              color: Color(0xff5EDA42),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(
              color: Color(0xff5EDA42),
            ),
          ),
        ),
      ),
    );
  }
}
