import 'package:flutter/material.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class CustomRadioWidgte extends StatefulWidget {
  const CustomRadioWidgte({
    super.key,
    required this.title,
    required this.value,
    required this.selectedSortOption,
    this.onChange,
  });
  final String title;
  final String value;
  final String? selectedSortOption;
  final void Function(String?)? onChange;

  @override
  State<CustomRadioWidgte> createState() => _CustomRadioWidgteState();
}

class _CustomRadioWidgteState extends State<CustomRadioWidgte> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 20,
        ),
        child: Row(
          children: [
            Text(
              widget.title,
              style: AppStyles.styleRegular16.copyWith(
                color: Color(0xff1A1A1A),
              ),
            ),
            Spacer(),
            Radio<String>(
              value: widget.value,
              groupValue: widget.selectedSortOption,
              onChanged: widget.onChange,
              activeColor: Color(0xFF5EDA42),
            ),
          ],
        ),
      ),
    );
  }
}
