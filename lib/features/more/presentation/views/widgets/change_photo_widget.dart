import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';

class ChangePhotoWidget extends StatelessWidget {
  const ChangePhotoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            'https://i.pravatar.cc/150?img=3',
          ),
          radius: 55,
        ),
        Positioned(
          left: 80,
          top: 80,
          child: SvgPicture.asset(
            Assets.imagesAddPhotoWidget,
          ),
        ),
      ],
    );
  }
}
