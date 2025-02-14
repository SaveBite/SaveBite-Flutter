import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';

OverlayEntry? _overlayEntry;
String? text;

void removeOverlay() {
  if (_overlayEntry != null) {
    _overlayEntry!.remove();
    _overlayEntry = null;
  }
}

void showOverlayWidget(BuildContext context, String? content) {
  text = content;
  if (_overlayEntry != null) {
    // If an OverlayEntry is already visible, remove it
    _overlayEntry!.remove();
    _overlayEntry = null;
    return;
  }

  _overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 24,
      right: 0,
      left: MediaQuery.of(context).size.width * 0.2,
      child: Material(
        // Use Material to ensure proper shadow and shape
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        child:
            CustomMessageWidget(), // Replace YourWidget with the widget you want to display
      ),
    ),
  );

  Overlay.of(context).insert(_overlayEntry!);
}

class CustomMessageWidget extends StatelessWidget {
  const CustomMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.only(
        right: 24,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(4),
          topLeft: Radius.circular(4),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 65,
            decoration: BoxDecoration(
              color: Color(0xffFFE5E5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4),
                topLeft: Radius.circular(4),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          SvgPicture.asset(Assets.imagesFrame),
          SizedBox(
            width: 8,
          ),
          SizedBox(
            width: 150,
            child: Text(
              text ?? '',
              style: AppStyles.styleRegular14.copyWith(
                color: Color(0xffCC0000),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis, // Enable ellipsis
              maxLines: 2, // Limit to two lines
            ),
          ),
          SizedBox(
            width: 32,
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              removeOverlay();
            },
            child: SvgPicture.asset(Assets.imagesClose),
          ),
        ],
      ),
    );
  }
}
