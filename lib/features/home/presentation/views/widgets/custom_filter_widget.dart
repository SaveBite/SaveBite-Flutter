import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/features/home/presentation/views/widgets/sort_by_bottom_sheet.dart';

class CustomFilterWidget extends StatefulWidget {
  const CustomFilterWidget({super.key});

  @override
  State<CustomFilterWidget> createState() => _CustomFilterWidgetState();
}

class _CustomFilterWidgetState extends State<CustomFilterWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        showModalBottomSheet(
            context: context,
            builder: (modalContext) {
              return SortByBottomSheet(blocContext: context);
            });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _isPressed ? const Color(0xff4CAF50) : const Color(0xff5EDA42),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: SvgPicture.asset(
            Assets.imagesFilter,
            height: 20,
          ),
        ),
      ),
    );
  }
}
