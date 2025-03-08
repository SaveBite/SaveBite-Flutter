import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.content,
    required this.color,
    required this.borderColor,
    this.onTap,
  });

  final Widget content;
  final Color color;
  final Color borderColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material( // Add Material widget for InkWell to work
      color: Colors.transparent, // Make Material transparent
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4), // Match container's border radius
        child: Ink( // Use Ink to apply background and border
          width: double.infinity,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: color,
            border: Border.all(
              color: borderColor,
            ),
          ),
          child: Center(
            child: content,
          ),
        ),
      ),
    );
  }
}