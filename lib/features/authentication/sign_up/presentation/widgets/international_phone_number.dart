import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter/material.dart';

class CustomInternationalPhoneNumber extends StatefulWidget {
  const CustomInternationalPhoneNumber({
    super.key,
    required this.number,
    required TextEditingController phoneController,
  }) : _phoneController = phoneController;

  final PhoneNumber number;
  final TextEditingController _phoneController;

  @override
  State<CustomInternationalPhoneNumber> createState() =>
      _CustomInternationalPhoneNumberState();
}

class _CustomInternationalPhoneNumberState
    extends State<CustomInternationalPhoneNumber> {
  PhoneNumber number = PhoneNumber(isoCode: 'EG'); // Default country: Egypt
  String dialCode = "+20"; // Default dial code
  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber newNumber) {
        setState(() {
          dialCode = newNumber.dialCode ?? ""; // Update prefix on selection
        });
      },
      onInputValidated: (bool value) {
        print("Valid: $value");
      },
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType
            .BOTTOM_SHEET, // Shows country selector as bottom sheet
        useBottomSheetSafeArea: true,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      selectorTextStyle: TextStyle(color: Colors.black),
      initialValue: number,
      textFieldController: widget._phoneController,
      formatInput: true,
      keyboardType:
          TextInputType.numberWithOptions(signed: true, decimal: true),
      inputBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff5EDA42), width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      hintText: "",

      // Input decoration to ensure the country code is a prefix
      inputDecoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        // prefixText: "$dialCode ", // Dynamically updates country code
        prefixStyle: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        errorStyle: TextStyle(color: Color(0xffFF0000), fontSize: 12),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff5EDA42), width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff5EDA42), width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffCCCCCC)),
          borderRadius: BorderRadius.circular(4),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffFF0000)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color(0xffFF0000)), // Custom color for errors
        ),
      ),
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      onSaved: (PhoneNumber newNumber) {
        print('On Saved: $newNumber');
      },
    );
  }
}
