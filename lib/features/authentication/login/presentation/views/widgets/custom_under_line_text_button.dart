import 'package:flutter/material.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class CustomUnderLineTextButton extends StatefulWidget {
  const CustomUnderLineTextButton({super.key, required this.title, this.onTap});

  final String title;
  final void Function()? onTap;

  @override
  State<CustomUnderLineTextButton> createState() =>
      _CustomUnderLineTextButtonState();
}

class _CustomUnderLineTextButtonState extends State<CustomUnderLineTextButton> {
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: AppStyles.styleRegular13.copyWith(
                color: const Color(0xff000000),
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
