import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class CustomTrackingButton extends StatefulWidget {
  const CustomTrackingButton({super.key});

  @override
  State<CustomTrackingButton> createState() => _CustomTrackingButtonState();
}

class _CustomTrackingButtonState extends State<CustomTrackingButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95; // تصغير بسيط وقت الضغط
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0; // يرجع للحجم الطبيعي بعد الضغط
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0; // لو المستخدم لغى الضغط، يرجع طبيعي
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // هنا تحط الوظيفة اللي عايزها تتنفذ عند الضغط
      },
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          width: double.infinity,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xff5EDA42),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 0.9,
                  child: SvgPicture.asset(Assets.imagesTrackingPlus),
                ),
                const SizedBox(width: 3),
                Text(
                  'Add new',
                  style: AppStyles.styleBold16.copyWith(
                    color: const Color(0xffFFFFFF),
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
