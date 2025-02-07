import 'package:flutter/material.dart';

class VerificationContainer extends StatelessWidget {
  final bool isValid;
  final TextEditingController controller;
  final bool isError;

  const VerificationContainer({
    Key? key,
    required this.isValid,
    required this.controller,
    required this.isError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isError ? Color(0xffFF0000) : Color(0xff5EDA42), // ✅ Green by default, red on error
          width: 2,
        ),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          fontFamily: 'Noto Sans',
          color: isError ? Color(0xffFF0000) : Colors.black, // ✅ Black by default, red on error
        ),
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
