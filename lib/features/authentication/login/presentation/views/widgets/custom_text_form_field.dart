import 'package:flutter/material.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    this.onChanged,
    this.prefixWidget,
    this.obscureToggleWidget, // Widget for toggling obscure text
    this.visibleToggleWidget, // Widget for showing visible text
    this.defaultSuffixWidget, // Default suffix widget when obscureText is false
    this.obscureText,
    this.validator,
  });

  final String hint;
  final void Function(String)? onChanged;
  final Widget? prefixWidget;
  final Widget? obscureToggleWidget;
  final Widget? visibleToggleWidget;
  final Widget? defaultSuffixWidget;
  final bool? obscureText;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppStyles.styleRegular16.copyWith(color: Color(0xff333333)),
      validator: widget.validator,
      onChanged: widget.onChanged,
      obscureText: _isObscure,
      decoration: InputDecoration(
        prefixIcon: widget.prefixWidget,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: _buildSuffixWidget(), // Use a function to build the suffix
        ),
        suffixIconConstraints: const BoxConstraints(
          maxWidth: 40,
          maxHeight: 22.5,
        ),
        contentPadding: const EdgeInsets.only(left: 16, top: 20, bottom: 20),
        filled: true,
        fillColor: const Color(0xffffffff),
        hintText: widget.hint,
        hintStyle: AppStyles.styleRegular16.copyWith(
          color: const Color(0xffCCCCCC),
          fontSize: 14,
        ),
        border: generateBorder(const Color(0xffCCCCCC)),
        enabledBorder: generateBorder(const Color(0xffCCCCCC)),
        focusedBorder: generateBorder(const Color(0xff5EDA42)),
        errorBorder: generateBorder(const Color(0xffFF0000)),
      ),
    );
  }

  Widget _buildSuffixWidget() {
    if (widget.obscureText != null) {
      if (_isObscure) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
          child: widget.obscureToggleWidget ?? const SizedBox.shrink(),
        );
      } else {
        return GestureDetector(
          onTap: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
          child: widget.visibleToggleWidget ?? const SizedBox.shrink(),
        );
      }
    } else {
      return widget.defaultSuffixWidget ?? const SizedBox.shrink();
    }
  }

  OutlineInputBorder generateBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: color,
        width: 1,
      ),
    );
  }
}
