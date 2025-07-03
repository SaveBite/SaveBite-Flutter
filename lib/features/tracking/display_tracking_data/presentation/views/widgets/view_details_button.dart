import 'package:flutter/material.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class ViewDetailButton extends StatelessWidget {
  final void Function()? onTap;
  const ViewDetailButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // View details action
      child: Container(
        height: 43,
        width: 110,
        decoration: BoxDecoration(
          color: const Color(0xffF6F6F6),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            'View Details',
            style: AppStyles.styleRegular16.copyWith(
              color: const Color(0xff1A1A1A),
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
