import 'package:flutter/material.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class CustomTextButton extends StatefulWidget {
  const CustomTextButton(
      {super.key,
      required this.title,
      this.onTap,
      this.textStyle = AppStyles.styleRegular13});
  final String title;
  final void Function()? onTap;
  final TextStyle textStyle;

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _scale,
        child: Text(
          widget.title,
          style: widget.textStyle,
        ),
      ),
    );
  }
}
